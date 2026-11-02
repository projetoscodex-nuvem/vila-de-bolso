extends SceneTree
## Synthetic OS input through Godot's Input pipeline, not calls to app._input.
## No Button.pressed emission: controls must react to real routed events.

const Main = preload("res://scenes/main.tscn")
var failures := 0
var checks := 0
var save_path := "user://m01_input_pipeline.json"

func _initialize() -> void:
	run.call_deferred()

func check(condition: bool, name: String) -> void:
	checks += 1
	if not condition:
		failures += 1
		push_error("FAIL INPUT PIPELINE: " + name)

func frames(count: int = 3) -> void:
	for i in range(count):
		await process_frame

func button(node: Node, text: String) -> Button:
	if node is Button and node.text == text:
		return node
	for child in node.get_children():
		var found := button(child, text)
		if found != null:
			return found
	return null

func send_touch(id: int, point: Vector2, pressed: bool, cancelled: bool = false) -> void:
	var event := InputEventScreenTouch.new()
	event.index = id
	event.position = point
	event.pressed = pressed
	event.canceled = cancelled
	Input.parse_input_event(event)
	Input.flush_buffered_events()

func send_drag(id: int, point: Vector2, delta: Vector2) -> void:
	var event := InputEventScreenDrag.new()
	event.index = id
	event.position = point
	event.relative = delta
	Input.parse_input_event(event)
	Input.flush_buffered_events()

func tap_button(app: Control, text: String) -> void:
	var target := button(app, text)
	check(target != null and target.is_visible_in_tree() and not target.disabled, "button available: " + text)
	if target == null:
		return
	var point := target.get_global_rect().get_center()
	send_touch(0, point, true)
	await frames(1)
	send_touch(0, point, false)
	await frames()

func mouse_button(point: Vector2, pressed: bool) -> void:
	var event := InputEventMouseButton.new()
	event.device = 0 # Physical mouse, not DEVICE_ID_EMULATION.
	event.position = point
	event.global_position = point
	event.button_index = MOUSE_BUTTON_LEFT
	event.button_mask = MOUSE_BUTTON_MASK_LEFT if pressed else 0
	event.pressed = pressed
	Input.parse_input_event(event)
	Input.flush_buffered_events()

func run() -> void:
	root.size = Vector2i(720, 1280)
	for suffix in ["", ".tmp", ".bak"]:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(save_path + suffix))
	var app: Control = Main.instantiate()
	app.store.path = save_path
	root.add_child(app)
	await frames()
	check(app.view == "menu", "initial menu")
	await tap_button(app, "Explorar reino")
	check(app.view == "kingdom", "touch through Input opens kingdom")
	if app.view != "kingdom":
		app.queue_free()
		await frames()
		finish()
		return

	app.camera.center = Vector2(640, 640)
	app.camera.clamp_position()
	var point: Vector2 = app.map.global_position + app.camera.world_to_screen(Vector2(640, 640))
	send_touch(0, point, true)
	check(app.gestures.contacts.size() == 1 and app.gestures.contacts.has(0), "one finger creates exactly one touch contact")
	check(not app.gestures.contacts.has(-10), "emulated mouse does not duplicate touch")
	check(app.gestures.mode == "tap_candidate", "one finger is not pinch")
	check(app.selected_region == "", "region not selected on press")
	send_touch(0, point, false)
	await frames()
	check(app.selected_region == "region_1" and app.view == "kingdom", "single tap selects region without entering")
	check(app.gestures.contacts.is_empty(), "touch release clears contact")
	await tap_button(app, "Entrar na Planície")
	check(app.view == "region_1", "touch Enter opens region")

	point = app.map.global_position + app.map.size * 0.5
	send_touch(0, point, true)
	send_touch(0, point, false)
	await frames()
	check(app.selection.x >= 0, "single touch selects cell")
	var before: Vector2 = app.camera.center
	send_touch(0, point, true)
	send_drag(0, point + Vector2(90, 40), Vector2(90, 40))
	check(app.gestures.mode == "pan" and app.gestures.contacts.size() == 1, "one-finger drag is pan, not pinch")
	check(app.camera.center.distance_to(before) > 1.0, "touch pan moves camera")
	check(app.selection.x == -1, "pan invalidates selection")
	send_touch(0, point + Vector2(90, 40), false)
	await frames()
	check(app.selection.x == -1 and app.gestures.contacts.is_empty(), "pan release does not become tap")

	send_touch(0, point - Vector2(60, 0), true)
	send_touch(1, point + Vector2(60, 0), true)
	check(app.gestures.mode == "pinch" and app.gestures.contacts.size() == 2, "two fingers make exactly two pinch contacts")
	var zoom: float = app.camera.zoom
	send_drag(1, point + Vector2(100, 0), Vector2(40, 0))
	check(app.camera.zoom > zoom, "two-finger pinch zooms")
	send_touch(1, point + Vector2(100, 0), false)
	send_touch(0, point - Vector2(60, 0), false)
	await frames()
	check(app.selection.x == -1 and app.gestures.contacts.is_empty(), "pinch releases never select")

	var camera_before_hud: Dictionary = app.camera.snapshot()
	var hud_point: Vector2 = app.title.get_global_rect().get_center()
	send_touch(0, hud_point, true)
	send_drag(0, point, point - hud_point)
	send_touch(0, point, false)
	await frames()
	check(app.gestures.contacts.is_empty(), "touch starting on HUD never enters map router")
	check(app.camera.snapshot() == camera_before_hud and app.selection.x == -1, "HUD drag does not pan or select map")

	zoom = app.camera.zoom
	await tap_button(app, "+")
	check(app.camera.zoom > zoom and app.gestures.contacts.is_empty(), "touch zoom plus acts only as GUI action")
	zoom = app.camera.zoom
	await tap_button(app, "−")
	check(app.camera.zoom < zoom and app.gestures.contacts.is_empty(), "touch zoom minus")
	await tap_button(app, "Visão geral")
	check(is_equal_approx(app.camera.zoom, app.camera.minimum_zoom), "touch overview")
	await tap_button(app, "Recentrar")
	check(is_equal_approx(app.camera.zoom, app.camera.interaction_zoom), "touch recenter")
	var phase_camera: Dictionary = app.camera.snapshot()
	await tap_button(app, "← Voltar")
	check(app.view == "kingdom", "touch Back returns to kingdom")
	await tap_button(app, "← Voltar")
	check(app.view == "menu", "touch Back returns to menu")
	await tap_button(app, "Retomar exploração")
	check(app.view == "kingdom", "touch Resume works")
	app.camera.center = Vector2(640, 640)
	app.camera.clamp_position()
	point = app.map.global_position + app.camera.world_to_screen(Vector2(640, 640))
	send_touch(0, point, true)
	send_touch(0, point, false)
	await frames()
	await tap_button(app, "Entrar na Planície")
	check(app.view == "region_1" and app.camera.snapshot() == phase_camera, "touch Enter restores phase camera")

	# A real device=0 mouse must still select and pan after filtering emulated mice.
	point = app.map.global_position + app.map.size * 0.5
	mouse_button(point, true)
	check(app.gestures.contacts.size() == 1 and app.gestures.contacts.has(-10), "physical mouse remains supported")
	mouse_button(point, false)
	await frames()
	check(app.selection.x >= 0 and app.gestures.contacts.is_empty(), "physical mouse tap selects")
	mouse_button(point, true)
	var motion := InputEventMouseMotion.new()
	motion.device = 0
	motion.position = point + Vector2(60, 40)
	motion.global_position = motion.position
	motion.relative = Vector2(60, 40)
	motion.button_mask = MOUSE_BUTTON_MASK_LEFT
	Input.parse_input_event(motion)
	Input.flush_buffered_events()
	check(app.gestures.mode == "pan" and app.gestures.contacts.size() == 1, "physical mouse drag pans")
	mouse_button(motion.position, false)
	await frames()
	check(app.selection.x == -1, "physical mouse pan does not select")

	app.queue_free()
	await frames()
	var reopened: Control = Main.instantiate()
	reopened.store.path = save_path
	root.add_child(reopened)
	await frames()
	await tap_button(reopened, "Retomar exploração")
	check(reopened.view == "region_1", "touch Resume after reopening")
	check(reopened.gestures.contacts.is_empty() and reopened.selection.x == -1, "reopened touch resume has no pending gesture")
	reopened.queue_free()
	await frames()
	finish()

func finish() -> void:
	for suffix in ["", ".tmp", ".bak"]:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(save_path + suffix))
	print("M0.1 input_pipeline checks=%d failures=%d (synthetic Godot Input; Android physical NOT_RUN)" % [checks, failures])
	quit(0 if failures == 0 else 1)
