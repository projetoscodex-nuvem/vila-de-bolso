extends SceneTree
# Component/scene checks, including direct calls and button signals. These are
# NOT the touch accessibility proof; test_input_pipeline.gd exercises Godot Input.

const WorldData = preload("res://core/world_data.gd")
const Camera = preload("res://core/map_camera.gd")
const Router = preload("res://core/gesture_router.gd")
const Store = preload("res://core/save_store.gd")
const Main = preload("res://scenes/main.tscn")

var failures := 0
var checks := 0
var test_paths: Array[String] = []

func _initialize() -> void:
	run.call_deferred()

func check(condition: bool, name: String) -> void:
	checks += 1
	if not condition:
		failures += 1
		push_error("FAIL: " + name)

func near(a: Vector2, b: Vector2, name: String) -> void:
	check(a.distance_to(b) < 0.01, name)

func test_world() -> void:
	var world := WorldData.new()
	check(world.validate(), "world schema/IDs/slots/unlocks")
	check(world.dimensions("region_1") == Vector2i(20, 20), "phase dimensions")
	check(world.dimensions("kingdom") == Vector2i(40, 60), "kingdom dimensions")
	check(world.config.placements_future == 60 and world.config.offers_future == 62, "future parameters unchanged")
	for region in world.config.regions:
		var origin := Vector2i(region.column * 20, region.row * 20)
		check(world.to_global(region.id, Vector2i.ZERO) == origin, "local region origin")
		check(world.to_global(region.id, Vector2i(19, 19)) == origin + Vector2i(19, 19), "local far corner")
		check(world.region_at(origin).id == region.id, "region at first cell")
		check(world.region_at(origin + Vector2i(19, 19)).id == region.id, "region at last cell")
	check(world.region_at(Vector2i(-1, 0)).is_empty(), "negative kingdom coordinate rejected")
	check(world.region_at(Vector2i(40, 60)).is_empty(), "outer kingdom coordinate rejected")
	check(not world.contains("region_1", Vector2i(20, 0)), "phase right edge rejected")
	check(not world.contains("region_1", Vector2i(0, -1)), "phase negative edge rejected")
	check(world.contains("region_1", Vector2i(19, 19)), "phase final cell valid")
	# Same terrain at the local/global coordinates, rather than a decorative village.
	for y in range(20):
		check(world.terrain("region_1", Vector2i(8, y)) == world.terrain("kingdom", Vector2i(8, y)), "terrain projection")
	print("PASS: data, region IDs, locked regions and local/global boundaries")

func test_android_export_configuration() -> void:
	var preset := ConfigFile.new()
	check(preset.load("res://export_presets.cfg") == OK, "Android preset loads through Godot ConfigFile")
	check(not preset.get_value("preset.0.options", "gradle_build/use_gradle_build", true), "standard Android export keeps Gradle disabled")
	check(preset.get_value("preset.0.options", "gradle_build/min_sdk", "MISSING") == "", "min SDK inherits the precompiled template without Gradle override")
	check(preset.get_value("preset.0.options", "gradle_build/target_sdk", "MISSING") == "", "target SDK inherits the precompiled template without Gradle override")
	check(ProjectSettings.get_setting("rendering/textures/vram_compression/import_etc2_astc", false), "Android texture import is enabled before export")
	check(not preset.get_value("preset.0.options", "permissions/internet", true), "Android preset does not request Internet permission")
	print("PASS: standard Android export configuration and texture import")

func test_camera() -> void:
	var camera := Camera.new()
	for world in [Vector2(1280, 1280), Vector2(2560, 3840)]:
		for viewport in [Vector2(720, 900), Vector2(360, 640), Vector2(1080, 1800)]:
			camera.configure(world, viewport)
			camera.recenter()
			var visible: Vector2 = viewport / camera.zoom
			check(visible.x < world.x and visible.y < world.y, "initial crop exceeds screen in both axes")
			check(camera.screen_to_world(Vector2.ZERO).x > 0 and camera.screen_to_world(Vector2.ZERO).y > 0, "terrain beyond left/top crop")
			check(camera.screen_to_world(viewport).x < world.x and camera.screen_to_world(viewport).y < world.y, "terrain beyond right/bottom crop")
			camera.overview()
			check((viewport / camera.zoom).x >= world.x and (viewport / camera.zoom).y >= world.y, "overview contains full map")
	camera.configure(Vector2(2560, 3840), Vector2(720, 900))
	camera.recenter()
	var reference := Vector2(1000, 1800)
	var previous := camera.world_to_screen(reference)
	camera.pan(Vector2(160, -120))
	near(camera.world_to_screen(reference), previous + Vector2(160, -120), "paper-like pan follows finger")
	var focus := Vector2(240, 380)
	var under_focus := camera.screen_to_world(focus)
	camera.zoom_at(focus, 1.5)
	near(camera.screen_to_world(focus), under_focus, "pinch focus preserved away from clamp")
	for screen in [Vector2.ZERO, Vector2(100, 400), camera.viewport_size]:
		near(camera.world_to_screen(camera.screen_to_world(screen)), screen, "screen/world round trip under pan/zoom")
	for zoom in [0.3, 1.0, 2.5]:
		camera.zoom = zoom
		camera.center = Vector2(1280, 1920)
		camera.clamp_position()
		var cell := Vector2i(17, 29)
		var screen := camera.world_to_screen(Vector2(cell) * 64 + Vector2(32, 32))
		check(camera.cell_at(screen, 64) == cell, "cell conversion under variable zoom")
	camera.zoom_at(focus, 1000)
	check(camera.zoom == camera.maximum_zoom, "max zoom clamped")
	camera.pan(Vector2(100000, -100000))
	var half_visible := camera.viewport_size / camera.zoom * 0.5
	check(camera.center.x >= half_visible.x and camera.center.y <= camera.world_size.y - half_visible.y, "map cannot be lost outside bounds")
	camera.zoom_at(focus, 0.00001)
	check(camera.zoom == camera.minimum_zoom, "min zoom clamped")
	camera.recenter()
	var snap := camera.snapshot()
	var restored := Camera.new()
	restored.configure(camera.world_size, camera.viewport_size)
	check(restored.restore(snap), "valid camera snapshot")
	near(restored.center, camera.center, "camera center round trip")
	check(not restored.restore({"center": [NAN, 1], "zoom": 1}), "NaN camera rejected")
	check(not restored.restore({"center": [1, 2], "zoom": -1}), "negative zoom rejected")
	check(not restored.restore({"center": [1], "zoom": 1}), "invalid center rejected")
	check(restored.restore({"center": [-99999, 99999], "zoom": 999}), "finite out-of-bounds camera clamped")
	check(restored.zoom == restored.maximum_zoom and restored.center.x >= 0, "restored bounds valid")
	print("PASS: camera crops, transforms, pan/zoom, focus, overview, bounds and restore")

func test_gestures() -> void:
	var router := Router.new()
	check(router.press(0, Vector2(100, 100), true).kind == "none", "press does not select")
	check(router.release(0, Vector2(100, 100), true).kind == "tap", "tap recognized on release")
	router.press(0, Vector2(100, 100), true)
	check(router.motion(0, Vector2(110, 100)).kind == "none", "under threshold does not pan")
	check(router.motion(0, Vector2(160, 100)).kind == "pan", "threshold becomes pan")
	check(router.release(0, Vector2(160, 100), true).kind == "end", "pan cannot end as tap")
	router.press(0, Vector2(100, 100), true)
	check(router.press(1, Vector2(200, 100), true).kind == "cancel_selection", "second finger cancels selection")
	var action := router.motion(1, Vector2(240, 100))
	check(action.kind == "pinch" and is_equal_approx(action.factor, 1.4), "pinch ratio measured")
	check(router.release(1, Vector2(240, 100), true).kind == "cancel_selection", "pinch lift cancels")
	check(router.motion(0, Vector2(101, 100)).kind == "none", "remaining finger cannot re-arm tap")
	check(router.release(0, Vector2(101, 100), true).kind == "end", "pinch cannot end as tap")
	router.press(0, Vector2(100, 100), true)
	router.motion(0, Vector2(180, 100))
	router.press(1, Vector2(240, 100), true)
	check(router.motion(1, Vector2(280, 100)).kind == "pinch", "pan becomes pinch")
	router.press(2, Vector2(300, 100), true)
	check(router.mode == "cancelled", "third finger cancels until all lift")
	router.cancel()
	check(router.contacts.is_empty() and router.mode == "idle", "pause resets contacts")
	check(router.release(0, Vector2(100, 100), true).kind == "none", "cancelled release cannot select")
	check(router.press(8, Vector2.ZERO, false).kind == "none" and router.contacts.is_empty(), "HUD contact rejected")
	router.press(0, Vector2(100, 100), true)
	check(router.release(0, Vector2(100, 100), false).kind == "end", "release outside map not tap")
	router.press(0, Vector2(100, 100), true)
	check(router.release(0, Vector2(100, 100), true, true).kind == "end", "cancelled touch not tap")
	print("PASS: tap/pan/pinch, cancellation, extra fingers, HUD and interrupted gestures")

func new_path(name: String) -> String:
	var result := "user://m01_test_" + name + ".json"
	test_paths.append(result)
	for suffix in ["", ".bak", ".tmp"]:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(result + suffix))
	return result

func write_text(path: String, text: String) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(text)
	file.close()

func state() -> Dictionary:
	return {"schema_version": 1, "app_version": "0.0.1-m0.1", "active_view": "region_1", "cameras": {"region_1": {"center": [700, 650], "zoom": 1.2}}}

func same_saved_state(actual: Dictionary, expected: Dictionary) -> bool:
	if actual.get("active_view") != expected.active_view or actual.get("schema_version") != expected.schema_version:
		return false
	if actual.get("app_version") != expected.app_version or actual.get("cameras", {}).keys() != expected.cameras.keys():
		return false
	for id in expected.cameras:
		var a: Dictionary = actual.cameras[id]
		var b: Dictionary = expected.cameras[id]
		if Vector2(a.center[0], a.center[1]).distance_to(Vector2(b.center[0], b.center[1])) > 0.001 or not is_equal_approx(a.zoom, b.zoom):
			return false
	return true

func test_saves() -> void:
	var store := Store.new()
	store.path = new_path("roundtrip")
	check(store.load_state().status == "missing", "missing save")
	check(store.save_state(state()) == OK, "save succeeds")
	check(same_saved_state(store.load_state().data, state()), "minimum state round trip")
	var second := state()
	second.cameras.region_1.center = [800, 700]
	check(store.save_state(second) == OK, "subsequent save succeeds")
	check(same_saved_state(store.read_file(store.path + ".bak"), state()), "previous valid save kept as backup")
	write_text(store.path + ".tmp", "unfinished write")
	check(same_saved_state(store.load_state().data, second), "interrupted temp write ignored")
	write_text(store.path, "{broken")
	check(store.load_state().status == "recovered", "corrupt primary recovers valid backup")
	check(store.write_blocked, "recovery cannot overwrite corrupt original")
	check(store.save_state(state()) == ERR_INVALID_DATA and FileAccess.get_file_as_string(store.path) == "{broken", "bad original preserved")
	var incompatible := Store.new()
	incompatible.path = new_path("unsupported")
	write_text(incompatible.path, '{"schema_version":99}')
	check(incompatible.load_state().status == "blocked", "future schema blocked")
	check(incompatible.save_state(state()) == ERR_INVALID_DATA, "unknown schema not overwritten")
	var malformed := Store.new()
	malformed.path = new_path("invalid")
	check(malformed.save_state({}) == ERR_INVALID_DATA and not FileAccess.file_exists(malformed.path), "invalid envelope rejected")
	malformed.path = "user://directory_that_does_not_exist_m01/save.json"
	check(malformed.save_state(state()) != OK, "write failure returned")
	var camera := Camera.new()
	camera.configure(Vector2(1280, 1280), Vector2(720, 900))
	check(camera.restore(second.cameras.region_1), "saved camera can restore")
	print("PASS: save round trip, backup, interrupted write, corruption and I/O errors")

func touch(app: Control, id: int, point: Vector2, pressed: bool, cancelled: bool = false) -> void:
	var event := InputEventScreenTouch.new()
	event.index = id
	event.position = point
	event.pressed = pressed
	event.canceled = cancelled
	app._input(event)

func drag(app: Control, id: int, point: Vector2) -> void:
	var event := InputEventScreenDrag.new()
	event.index = id
	event.position = point
	app._input(event)

func frames(count: int = 3) -> void:
	for i in range(count):
		await process_frame

func test_ui() -> void:
	root.size = Vector2i(720, 1280)
	var app: Control = Main.instantiate()
	app.store.path = new_path("app")
	root.add_child(app)
	await frames()
	check(app.view == "menu" and app.menu.visible, "menu starts")
	app.enter_view("region_2")
	check(app.view == "menu", "locked region cannot be entered even through API")
	app.enter_view("kingdom")
	await frames()
	check(app.view == "kingdom" and app.map.size.y > 120, "menu to kingdom")
	check(app.map.size.x / app.camera.zoom < 2560 and app.map.size.y / app.camera.zoom < 3840, "kingdom crop in scene")
	var hud_position: Vector2 = app.title.global_position
	var original_data: String = JSON.stringify(app.world.config)
	# Move to the first region through the same camera used by touch; select explicitly.
	app.camera.center = Vector2(640, 640)
	app.camera.clamp_position()
	var point: Vector2 = app.map.global_position + app.camera.world_to_screen(Vector2(640, 640))
	touch(app, 0, point, true)
	check(app.selected_region == "", "touch-down does not select region")
	touch(app, 0, point, false)
	check(app.selected_region == "region_1" and app.view == "kingdom", "tap selects without entering")
	app.enter_button.pressed.emit()
	await frames()
	check(app.view == "region_1", "explicit Enter opens phase one")
	check(app.map.size.x / app.camera.zoom < 1280 and app.map.size.y / app.camera.zoom < 1280, "phase crop in scene")
	point = app.map.global_position + app.map.size * 0.5
	touch(app, 0, point, true)
	touch(app, 0, point, false)
	check(app.selection.x >= 0, "phase selection")
	touch(app, 0, point, true)
	touch(app, 0, point, false, true)
	check(app.selection.x == -1 and app.gestures.contacts.is_empty(), "cancelled OS touch clears pending actions")
	touch(app, 0, point, true)
	touch(app, 0, point, false)
	touch(app, 0, point, true)
	drag(app, 0, point + Vector2(90, 50))
	check(app.selection == Vector2i(-1, -1), "pan clears old selection")
	touch(app, 0, point + Vector2(90, 50), false)
	check(app.selection == Vector2i(-1, -1), "pan release does not select")
	touch(app, 0, point - Vector2(60, 0), true)
	touch(app, 1, point + Vector2(60, 0), true)
	var before_zoom: float = app.camera.zoom
	drag(app, 1, point + Vector2(100, 0))
	check(app.camera.zoom > before_zoom, "synthetic touch pinch changes actual scene camera")
	touch(app, 1, point + Vector2(100, 0), false)
	touch(app, 0, point - Vector2(60, 0), false)
	check(app.selection == Vector2i(-1, -1), "pinch releases do not select")
	near(app.title.global_position, hud_position, "HUD fixed during navigation")
	var before_ui: Dictionary = app.camera.snapshot()
	touch(app, 7, Vector2(20, 20), true)
	drag(app, 7, Vector2(400, 400))
	touch(app, 7, Vector2(400, 400), false)
	check(app.gestures.contacts.is_empty() and app.camera.snapshot() == before_ui, "gesture starting on HUD does not pan map")
	app._overview()
	check(app.camera.zoom == app.camera.minimum_zoom, "scene overview button")
	app._zoom(1.25)
	check(app.camera.zoom > app.camera.minimum_zoom, "scene zoom button")
	app._recenter()
	check(app.camera.zoom == app.camera.interaction_zoom, "scene recenter button")
	app.camera.pan(Vector2(60, 40))
	app._remember_camera()
	app._persist()
	var phase_camera: Dictionary = app.camera.snapshot()
	app._notification(Node.NOTIFICATION_WM_GO_BACK_REQUEST)
	await frames()
	check(app.view == "kingdom", "phase back to kingdom")
	near(app.camera.center, Vector2(640, 640), "kingdom camera restored independently")
	app.enter_view("region_1")
	await frames()
	check(app.camera.snapshot() == phase_camera, "phase camera restored independently")
	touch(app, 0, app.map.global_position + app.map.size * 0.5, true)
	app._notification(Node.NOTIFICATION_APPLICATION_FOCUS_OUT)
	check(app.gestures.contacts.is_empty() and app.selection.x == -1, "background clears contacts and selection")
	check(app.envelope().cameras.has("kingdom") and app.envelope().cameras.has("region_1"), "both cameras saved")
	check(not app.envelope().has("selection") and not app.envelope().has("contacts"), "transient actions never serialized")
	check(JSON.stringify(app.world.config) == original_data, "navigation never changes world/turn/offer data")
	var path: String = app.store.path
	app.queue_free()
	await frames()
	var restarted: Control = Main.instantiate()
	restarted.store.path = path
	root.add_child(restarted)
	await frames()
	check(restarted.has_resume and restarted.active_view == "region_1", "reopened app knows last view")
	restarted.resume_button.pressed.emit()
	await frames()
	check(restarted.view == "region_1", "restart/resume restores phase view")
	near(restarted.camera.center, Vector2(phase_camera.center[0], phase_camera.center[1]), "restart/resume restores phase center")
	check(is_equal_approx(restarted.camera.zoom, phase_camera.zoom), "restart/resume restores phase zoom")
	check(restarted.selection.x == -1 and restarted.gestures.contacts.is_empty(), "restart has no pending selection or fingers")
	restarted.queue_free()
	await frames()
	print("PASS: scene flow, locked regions, real input routing, selection, HUD, cameras and reopen")

func run() -> void:
	test_world()
	test_android_export_configuration()
	test_camera()
	test_gestures()
	test_saves()
	await test_ui()
	for path in test_paths:
		for suffix in ["", ".bak", ".tmp"]:
			DirAccess.remove_absolute(ProjectSettings.globalize_path(path + suffix))
	print("M0.1 checks=%d failures=%d" % [checks, failures])
	quit(0 if failures == 0 else 1)
