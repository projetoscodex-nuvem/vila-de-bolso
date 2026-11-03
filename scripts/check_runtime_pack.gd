extends SceneTree
## Runs only in a temporary directory via --main-pack, without source resources.
## Godot handles PCK/ZIP, .remap, binary scenes and compiled GDScript itself.

const REQUIRED_SCRIPTS := [
	"res://presentation/main.gd", "res://presentation/map_view.gd",
	"res://core/world_data.gd", "res://core/map_camera.gd",
	"res://core/gesture_router.gd", "res://core/save_store.gd",
]
const ALLOWED_ROOTS := [".godot", "assets", "core", "data", "licenses", "presentation", "scenes"]
var failures := 0

func _initialize() -> void:
	run.call_deferred()

func check(condition: bool, message: String) -> bool:
	if not condition:
		failures += 1
		push_error("FAIL RUNTIME PACK: " + message)
	return condition

func inspect_files(path: String) -> void:
	var directory := DirAccess.open(path)
	if not check(directory != null, "list " + path):
		return
	directory.include_hidden = true
	for file in directory.get_files():
		check(not file.ends_with(".md") and not file.ends_with(".zip") and not file.ends_with(".keystore") and not file.ends_with(".jks") and not file.begins_with(".env") and file != "export_credentials.cfg", "excluded private/tool file: " + path + file)
	for child in directory.get_directories():
		if path == "res://":
			check(child in ALLOWED_ROOTS, "unexpected runtime directory: " + child)
		inspect_files(path.path_join(child) + "/")

func resource(path: String) -> Resource:
	# A remap sidecar alone is insufficient: verify its target and actually load it.
	if FileAccess.file_exists(path + ".remap"):
		var remap := ConfigFile.new()
		if not check(remap.load(path + ".remap") == OK, "read remap: " + path):
			return null
		var target: String = remap.get_value("remap", "path", "")
		if not check(not target.is_empty() and FileAccess.file_exists(target), "missing remap target: " + path + " -> " + target):
			return null
	if not check(ResourceLoader.exists(path), "missing resource: " + path):
		return null
	var loaded := ResourceLoader.load(path)
	check(loaded != null, "load resource: " + path)
	return loaded

func find_button(node: Node, text: String) -> Button:
	if node is Button and node.text == text:
		return node
	for child in node.get_children():
		var found := find_button(child, text)
		if found != null:
			return found
	return null

func run() -> void:
	# --main-pack loads project.binary from the artifact. The directory on disk
	# contains only this test driver; absent pack resources cannot come from source.
	check(ProjectSettings.get_setting("application/run/main_scene", "") == "res://scenes/main.tscn", "exported main scene configuration")
	inspect_files("res://")
	for path in REQUIRED_SCRIPTS:
		var script := resource(path) as Script
		check(script != null and script.can_instantiate(), "required valid script: " + path)
	check(FileAccess.file_exists("res://data/world.json"), "world data")
	check(FileAccess.file_exists("res://licenses/GODOT_LICENSE.txt"), "Godot license")
	var scene := resource("res://scenes/main.tscn") as PackedScene
	if failures > 0 or scene == null:
		quit(1)
		return
	root.size = Vector2i(720, 1280)
	var app := scene.instantiate()
	if not check(app != null and app.get_script() != null, "instantiate scripted main scene"):
		quit(1)
		return
	root.add_child(app)
	current_scene = app
	for i in range(5):
		await process_frame
	check(app.get("view") == "menu", "initial menu state")
	var menu: Variant = app.get("menu")
	check(menu is Control and menu.is_visible_in_tree(), "menu exists and visible in tree")
	for text in ["Explorar reino", "Retomar exploração", "Créditos e licenças"]:
		var button := find_button(app, text)
		check(button != null and button.is_visible_in_tree() and root.get_visible_rect().intersection(button.get_global_rect()).has_area(), "visible menu button: " + text)
	if failures == 0:
		print("PASS: isolated exported runtime dependencies, scene and visible menu (headless; Android physical NOT_RUN)")
	app.queue_free()
	await process_frame
	quit(0 if failures == 0 else 1)
