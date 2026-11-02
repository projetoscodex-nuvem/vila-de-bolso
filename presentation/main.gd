extends Control

const WorldData = preload("res://core/world_data.gd")
const MapCamera = preload("res://core/map_camera.gd")
const GestureRouter = preload("res://core/gesture_router.gd")
const SaveStore = preload("res://core/save_store.gd")
const MapView = preload("res://presentation/map_view.gd")

var world := WorldData.new()
var camera := MapCamera.new()
var gestures := GestureRouter.new()
var store := SaveStore.new()
var cameras: Dictionary = {}
var view := "menu"
var active_view := "kingdom"
var selection := Vector2i(-1, -1)
var selected_region := ""
var save_message := ""
var has_resume := false
var ready_for_notifications := false
var menu: VBoxContainer
var shell: VBoxContainer
var map: Control
var title: Label
var info: Label
var enter_button: Button
var resume_button: Button
var credits: PanelContainer

func _ready() -> void:
	assert(world.validate())
	gestures.threshold = world.config.tap_drag_threshold
	_build_ui()
	var saved := store.load_state()
	if not saved.data.is_empty():
		active_view = saved.data.active_view
		cameras = saved.data.cameras
		has_resume = true
	if saved.status in ["blocked", "recovered"]:
		save_message = "Não foi possível carregar a exploração. A cópia anterior foi preservada; gravação indisponível."
		if saved.status == "recovered":
			save_message = "Exploração recuperada de uma cópia anterior. O arquivo com erro foi preservado; gravação indisponível."
	resume_button.disabled = not has_resume
	ready_for_notifications = true
	show_menu()

func _button(text: String, action: Callable, parent: Node) -> Button:
	var button := Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(0, 60)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.pressed.connect(action)
	parent.add_child(button)
	return button

func _label(text: String, parent: Node, font_size: int = 24) -> Label:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", font_size)
	parent.add_child(label)
	return label

func _build_ui() -> void:
	var ui_theme := Theme.new()
	ui_theme.default_font_size = 24
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color("e4d9b6")
	normal.border_color = Color("516b50")
	normal.set_border_width_all(2)
	normal.set_corner_radius_all(10)
	normal.content_margin_left = 14
	normal.content_margin_right = 14
	ui_theme.set_stylebox("normal", "Button", normal)
	var hover := normal.duplicate()
	hover.bg_color = Color("cdd3a6")
	ui_theme.set_stylebox("hover", "Button", hover)
	ui_theme.set_stylebox("pressed", "Button", hover)
	ui_theme.set_color("font_color", "Button", Color("253d32"))
	ui_theme.set_color("font_color", "Label", Color("253d32"))
	theme = ui_theme
	var background := ColorRect.new()
	background.color = Color("f0ecd8")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	for edge in ["left", "top", "right", "bottom"]:
		margin.add_theme_constant_override("margin_" + edge, 16)
	add_child(margin)
	var stack := VBoxContainer.new()
	stack.add_theme_constant_override("separation", 12)
	margin.add_child(stack)
	menu = VBoxContainer.new()
	menu.size_flags_vertical = Control.SIZE_EXPAND_FILL
	menu.alignment = BoxContainer.ALIGNMENT_CENTER
	menu.add_theme_constant_override("separation", 24)
	stack.add_child(menu)
	_label("VILA DE BOLSO\nMeu Reino", menu, 46)
	_label("Explore o terreno. Encontre seu lugar.", menu, 28)
	_label("Fundação M0.1 · navegação e seleção\nAinda sem partida, construções ou pontuação.", menu)
	_button("Explorar reino", func(): enter_view("kingdom"), menu)
	resume_button = _button("Retomar exploração", func(): enter_view(active_view), menu)
	_button("Créditos e licenças", _show_credits, menu)
	_label("Arraste com um dedo. Use pinça para aproximar.\nO progresso de campanha ainda não está disponível.", menu)
	shell = VBoxContainer.new()
	shell.size_flags_vertical = Control.SIZE_EXPAND_FILL
	shell.add_theme_constant_override("separation", 10)
	stack.add_child(shell)
	var top := HBoxContainer.new()
	shell.add_child(top)
	_button("← Voltar", _back, top)
	title = _label("", top, 28)
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	map = MapView.new()
	map.world = world
	map.camera = camera
	map.size_flags_vertical = Control.SIZE_EXPAND_FILL
	map.custom_minimum_size = Vector2(100, 120)
	map.resized.connect(_resize_map)
	shell.add_child(map)
	var tools := HBoxContainer.new()
	shell.add_child(tools)
	_button("−", func(): _zoom(0.8), tools)
	_button("+", func(): _zoom(1.25), tools)
	_button("Recentrar", _recenter, tools)
	_button("Visão geral", _overview, tools)
	info = _label("", shell, 23)
	info.custom_minimum_size.y = 84
	enter_button = _button("Entrar na Planície", _enter_selected, shell)
	credits = PanelContainer.new()
	credits.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	credits.offset_left = 16
	credits.offset_right = -16
	credits.offset_top = 16
	credits.offset_bottom = -16
	add_child(credits)
	var credits_box := VBoxContainer.new()
	credits.add_child(credits_box)
	_label("Créditos · prova M0.1", credits_box, 30)
	var text := TextEdit.new()
	text.editable = false
	text.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY
	text.size_flags_vertical = Control.SIZE_EXPAND_FILL
	text.text = "Arte geométrica provisória do projeto; sem packs externos.\nGodot 4.6.3 — https://godotengine.org/license/\n\n" + Engine.get_license_text() + "\n\nAvisos de terceiros:\n" + JSON.stringify(Engine.get_copyright_info(), "  ") + "\n\n" + JSON.stringify(Engine.get_license_info(), "  ")
	credits_box.add_child(text)
	_button("Fechar créditos", func(): credits.hide(), credits_box)
	credits.hide()

func _show_credits() -> void:
	_cancel_gesture()
	credits.show()

func show_menu() -> void:
	if view != "menu":
		_remember_camera()
		_persist()
	_cancel_gesture()
	view = "menu"
	shell.hide()
	menu.show()
	resume_button.disabled = not has_resume

func enter_view(target: String) -> void:
	if target not in ["kingdom", "region_1"]:
		return
	if view != "menu":
		_remember_camera()
	_cancel_gesture()
	view = target
	active_view = target
	map.view = view
	menu.hide()
	shell.show()
	title.text = "Meu Reino · 0/6" if view == "kingdom" else "Planície · exploração"
	enter_button.visible = view == "kingdom"
	_configure_view.call_deferred()

func _configure_view() -> void:
	if view == "menu":
		return
	camera.configure(world.world_size(view), map.size)
	camera.restore(cameras.get(view, {}))
	_refresh()
	_remember_camera()
	_persist()

func _resize_map() -> void:
	if view != "menu" and map.size.x > 0 and map.size.y > 0:
		camera.configure(world.world_size(view), map.size)
		_refresh()

func _remember_camera() -> void:
	if view in ["kingdom", "region_1"]:
		cameras[view] = camera.snapshot()

func envelope() -> Dictionary:
	return {"schema_version": 1, "app_version": "0.0.1-m0.1", "active_view": active_view, "cameras": cameras.duplicate(true)}

func _persist() -> void:
	var error := store.save_state(envelope())
	if error == OK:
		has_resume = true
	elif save_message.is_empty():
		save_message = "Não foi possível salvar. Sua cópia anterior foi preservada."
	if view != "menu":
		_refresh()

func _back() -> void:
	if view == "region_1":
		enter_view("kingdom")
	else:
		show_menu()

func _enter_selected() -> void:
	if view == "kingdom" and selected_region == "region_1":
		enter_view("region_1")

func _clear_selection() -> void:
	selection = Vector2i(-1, -1)
	selected_region = ""
	if map != null:
		map.selected_cell = selection
		map.selected_region = ""

func _cancel_gesture() -> void:
	gestures.cancel()
	_clear_selection()

func _refresh() -> void:
	map.selected_cell = selection
	map.selected_region = selected_region
	map.queue_redraw()
	enter_button.disabled = selected_region != "region_1"
	if not save_message.is_empty():
		info.text = save_message
	elif view == "kingdom":
		var region := world.region_by_id(selected_region)
		info.text = "Arraste ou use pinça. Toque para selecionar uma região."
		if not region.is_empty():
			info.text = region.name + (" · toque em Entrar para explorar." if region.unlocked else " · bloqueada nesta prova.")
	else:
		info.text = "Toque para inspecionar uma célula. Construções ficam para M1."
		if selection.x >= 0:
			info.text = "Célula (%d, %d) · %s\nSomente seleção; nenhuma construção." % [selection.x, selection.y, world.terrain(view, selection)]

func apply_gesture(action: Dictionary) -> void:
	match action.kind:
		"tap":
			var cell: Vector2i = camera.cell_at(action.point, world.config.cell_size)
			_clear_selection()
			if world.contains(view, cell):
				if view == "kingdom":
					selected_region = world.region_at(cell).get("id", "")
				else:
					selection = cell
					if camera.zoom < camera.interaction_zoom:
						camera.zoom_at(action.point, camera.interaction_zoom / camera.zoom)
			_remember_camera()
			_persist()
		"pan":
			_clear_selection()
			camera.pan(action.delta)
		"pinch":
			_clear_selection()
			camera.zoom_at(action.anchor, action.factor)
			camera.pan(action.delta)
		"cancel_selection":
			_clear_selection()
		"end":
			_remember_camera()
			_persist()
	_refresh()

func _zoom(factor: float) -> void:
	_cancel_gesture()
	camera.zoom_at(map.size * 0.5, factor)
	_remember_camera()
	_persist()

func _recenter() -> void:
	_cancel_gesture()
	camera.recenter()
	_remember_camera()
	_persist()

func _overview() -> void:
	_cancel_gesture()
	camera.overview()
	_remember_camera()
	_persist()

func _input(event: InputEvent) -> void:
	# Godot's GUI needs touch-to-mouse emulation for Button controls. These
	# emulated mouse events must reach the GUI, but never become a second map
	# contact alongside the original ScreenTouch/ScreenDrag. Device 0 (physical
	# mouse) continues through the mouse navigation path below.
	if event is InputEventMouse and event.device == InputEvent.DEVICE_ID_EMULATION:
		return
	if view == "menu" or credits.visible:
		return
	if event.is_action_pressed("ui_cancel"):
		_back()
		get_viewport().set_input_as_handled()
		return
	var id := -1
	var point := Vector2.ZERO
	var operation := ""
	var cancelled := false
	if event is InputEventScreenTouch:
		id = event.index
		point = event.position
		operation = "press" if event.pressed else "release"
		cancelled = event.canceled
	elif event is InputEventScreenDrag:
		id = event.index
		point = event.position
		operation = "motion"
	elif event is InputEventMouseButton:
		point = event.position
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
			if event.pressed and map.get_global_rect().has_point(point):
				_cancel_gesture()
				camera.zoom_at(point - map.global_position, 1.2 if event.button_index == MOUSE_BUTTON_WHEEL_UP else 1.0 / 1.2)
				_remember_camera()
				_persist()
				get_viewport().set_input_as_handled()
			return
		if event.button_index != MOUSE_BUTTON_LEFT:
			return
		id = -10
		operation = "press" if event.pressed else "release"
	elif event is InputEventMouseMotion:
		id = -10
		point = event.position
		operation = "motion"
	else:
		return
	if cancelled:
		_cancel_gesture()
		_remember_camera()
		_persist()
		get_viewport().set_input_as_handled()
		return
	var inside := map.get_global_rect().has_point(point)
	if (operation == "press" and not inside) or (operation != "press" and not gestures.contacts.has(id)):
		return
	var local := point - map.global_position
	var action: Dictionary
	if operation == "press":
		action = gestures.press(id, local, inside)
	elif operation == "motion":
		action = gestures.motion(id, local)
	else:
		action = gestures.release(id, local, inside, cancelled)
	apply_gesture(action)
	get_viewport().set_input_as_handled()

func _notification(what: int) -> void:
	if not ready_for_notifications:
		return
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_back()
		return
	if what in [NOTIFICATION_APPLICATION_PAUSED, NOTIFICATION_APPLICATION_FOCUS_OUT, NOTIFICATION_WM_CLOSE_REQUEST]:
		_cancel_gesture()
		_remember_camera()
		_persist()
