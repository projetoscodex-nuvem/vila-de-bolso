extends Control

var world: RefCounted
var camera: RefCounted
var view := "kingdom"
var selected_cell := Vector2i(-1, -1)
var selected_region := ""

func _ready() -> void:
	clip_contents = true
	mouse_filter = Control.MOUSE_FILTER_STOP

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color("334d45"))
	if world == null or camera == null:
		return
	var tile: float = world.config.cell_size
	var dimensions: Vector2i = world.dimensions(view)
	var first := Vector2i((camera.screen_to_world(Vector2.ZERO) / tile).floor()).max(Vector2i.ZERO)
	var last := Vector2i((camera.screen_to_world(size) / tile).ceil()).min(dimensions)
	draw_set_transform(size * 0.5 - camera.center * camera.zoom, 0.0, Vector2.ONE * camera.zoom)
	for y in range(first.y, last.y):
		for x in range(first.x, last.x):
			var cell := Vector2i(x, y)
			var kind: String = world.terrain(view, cell)
			var color := Color("91ae72") if (x + y) % 2 == 0 else Color("89a76c")
			if kind == "water": color = Color("6aa9b8")
			if kind == "rock": color = Color("adb09c")
			if kind == "forest": color = Color("618553")
			var rectangle := Rect2(Vector2(cell) * tile, Vector2.ONE * tile)
			draw_rect(rectangle, color)
			draw_rect(rectangle, Color(0.15, 0.24, 0.15, 0.14), false, 1.0)
			if kind == "forest":
				draw_circle(rectangle.get_center(), 15, Color("426f4c"))
			if kind == "rock":
				draw_rect(Rect2(rectangle.position + Vector2(19, 22), Vector2(26, 21)), Color("818a7c"))
	if view == "kingdom":
		for region in world.config.regions:
			var position := Vector2(region.column * world.config.phase_width, region.row * world.config.phase_height) * tile
			var rectangle := Rect2(position, Vector2(world.config.phase_width, world.config.phase_height) * tile)
			if not region.unlocked:
				draw_rect(rectangle, Color(0.1, 0.17, 0.16, 0.42))
			draw_rect(rectangle.grow(-3), Color("eadba7") if region.id == selected_region else Color("405d43"), false, 6.0)
			var caption: String = region.name + ("" if region.unlocked else " · bloqueada")
			draw_string(ThemeDB.fallback_font, position + Vector2(24, 52), caption, HORIZONTAL_ALIGNMENT_LEFT, -1, 30, Color("fff1c9"))
	elif world.contains(view, selected_cell):
		var rectangle := Rect2(Vector2(selected_cell) * tile, Vector2.ONE * tile)
		draw_rect(rectangle.grow(-3), Color("fff3bd"), false, 5)
	draw_set_transform(Vector2.ZERO)
