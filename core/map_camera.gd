extends RefCounted
## Screen coordinates are local to the map Control, excluding fixed HUD.

var world_size := Vector2(1280, 1280)
var viewport_size := Vector2(720, 900)
var center := Vector2(640, 640)
var zoom := 1.0
var interaction_zoom := 1.0
var minimum_zoom := 0.5
var maximum_zoom := 3.0

func configure(world: Vector2, viewport: Vector2) -> void:
	world_size = world.max(Vector2.ONE)
	viewport_size = viewport.max(Vector2.ONE)
	minimum_zoom = minf(viewport_size.x / world_size.x, viewport_size.y / world_size.y) * 0.92
	# Strictly more world than viewport in BOTH axes at initial interaction scale.
	interaction_zoom = maxf(1.0, maxf(viewport_size.x / world_size.x, viewport_size.y / world_size.y) * 1.3)
	maximum_zoom = maxf(3.0, interaction_zoom * 2.0)
	zoom = clampf(zoom, minimum_zoom, maximum_zoom)
	clamp_position()

func recenter() -> void:
	center = world_size * 0.5
	zoom = interaction_zoom
	clamp_position()

func overview() -> void:
	center = world_size * 0.5
	zoom = minimum_zoom
	clamp_position()

func screen_to_world(screen: Vector2) -> Vector2:
	return (screen - viewport_size * 0.5) / zoom + center

func world_to_screen(world: Vector2) -> Vector2:
	return (world - center) * zoom + viewport_size * 0.5

func cell_at(screen: Vector2, cell_size: float) -> Vector2i:
	return Vector2i((screen_to_world(screen) / cell_size).floor())

func pan(delta: Vector2) -> void:
	center -= delta / zoom
	clamp_position()

func zoom_at(screen: Vector2, factor: float) -> void:
	if not is_finite(factor) or factor <= 0.0:
		return
	var before := screen_to_world(screen)
	zoom = clampf(zoom * factor, minimum_zoom, maximum_zoom)
	center += before - screen_to_world(screen)
	clamp_position()

func clamp_position() -> void:
	var half_visible := viewport_size * 0.5 / zoom
	for axis in range(2):
		if half_visible[axis] * 2.0 >= world_size[axis]:
			center[axis] = world_size[axis] * 0.5
		else:
			center[axis] = clampf(center[axis], half_visible[axis], world_size[axis] - half_visible[axis])

func snapshot() -> Dictionary:
	return {"center": [center.x, center.y], "zoom": zoom}

func restore(value: Variant) -> bool:
	if not value is Dictionary or not value.get("center") is Array or value.center.size() != 2:
		recenter()
		return false
	for number in [value.center[0], value.center[1], value.get("zoom")]:
		if not (number is float or number is int) or not is_finite(float(number)):
			recenter()
			return false
	if value.zoom <= 0.0:
		recenter()
		return false
	center = Vector2(value.center[0], value.center[1])
	zoom = clampf(value.zoom, minimum_zoom, maximum_zoom)
	clamp_position()
	return true
