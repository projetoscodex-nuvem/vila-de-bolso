extends RefCounted
## Data and provisional terrain for the navigation proof. No game rules or score.

var config: Dictionary

func _init() -> void:
	config = JSON.parse_string(FileAccess.get_file_as_string("res://data/world.json"))

func validate() -> bool:
	if config.get("schema_version") != 1 or config.get("cell_size", 0) <= 0:
		return false
	if config.phase_width * 2 != config.kingdom_width or config.phase_height * 3 != config.kingdom_height:
		return false
	if config.regions.size() != 6:
		return false
	var ids: Dictionary = {}
	var slots: Dictionary = {}
	for region in config.regions:
		var slot := Vector2i(region.column, region.row)
		if ids.has(region.id) or slots.has(slot) or slot.x < 0 or slot.x >= 2 or slot.y < 0 or slot.y >= 3:
			return false
		ids[region.id] = true
		slots[slot] = true
		if bool(region.unlocked) != (region.id == "region_1"):
			return false
	return true

func dimensions(view: String) -> Vector2i:
	if view == "kingdom":
		return Vector2i(config.kingdom_width, config.kingdom_height)
	return Vector2i(config.phase_width, config.phase_height)

func world_size(view: String) -> Vector2:
	return Vector2(dimensions(view)) * float(config.cell_size)

func region_by_id(id: String) -> Dictionary:
	for region in config.regions:
		if region.id == id:
			return region
	return {}

func region_at(cell: Vector2i) -> Dictionary:
	if not contains("kingdom", cell):
		return {}
	for region in config.regions:
		if region.column == cell.x / int(config.phase_width) and region.row == cell.y / int(config.phase_height):
			return region
	return {}

func contains(view: String, cell: Vector2i) -> bool:
	var size := dimensions(view)
	return cell.x >= 0 and cell.y >= 0 and cell.x < size.x and cell.y < size.y

func to_global(region_id: String, cell: Vector2i) -> Vector2i:
	var region := region_by_id(region_id)
	return cell + Vector2i(region.column * config.phase_width, region.row * config.phase_height)

func terrain(view: String, cell: Vector2i) -> String:
	var global_cell := cell if view == "kingdom" else to_global(view, cell)
	# Continuous river across region borders; provisional, unrelated to legacy PNGs.
	if global_cell.x == 8 + int(global_cell.y / 10) % 3:
		return "water"
	if (global_cell.x * 17 + global_cell.y * 13) % 29 == 0:
		return "rock"
	if (global_cell.x * 7 + global_cell.y * 11) % 19 == 0:
		return "forest"
	return "grass"
