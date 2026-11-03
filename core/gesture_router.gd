extends RefCounted
## Logical viewport units; threshold remains a prototype parameter for device testing.

var threshold := 18.0
var contacts: Dictionary = {}
var mode := "idle"
var origin := Vector2.ZERO

func press(id: int, point: Vector2, inside: bool) -> Dictionary:
	if not inside or contacts.has(id):
		return {"kind": "none"}
	contacts[id] = point
	if contacts.size() == 1:
		mode = "tap_candidate"
		origin = point
	elif contacts.size() == 2 and mode != "cancelled":
		mode = "pinch"
		return {"kind": "cancel_selection"}
	else:
		mode = "cancelled"
		return {"kind": "cancel_selection"}
	return {"kind": "none"}

func motion(id: int, point: Vector2) -> Dictionary:
	if not contacts.has(id) or mode == "cancelled":
		return {"kind": "none"}
	var previous: Vector2 = contacts[id]
	if contacts.size() == 2:
		var keys: Array = contacts.keys()
		var old_mid: Vector2 = (contacts[keys[0]] + contacts[keys[1]]) * 0.5
		var old_distance: float = contacts[keys[0]].distance_to(contacts[keys[1]])
		contacts[id] = point
		var new_mid: Vector2 = (contacts[keys[0]] + contacts[keys[1]]) * 0.5
		var new_distance: float = contacts[keys[0]].distance_to(contacts[keys[1]])
		var factor := 1.0 if old_distance < 1.0 else new_distance / old_distance
		return {"kind": "pinch", "anchor": old_mid, "delta": new_mid - old_mid, "factor": factor}
	contacts[id] = point
	if mode == "tap_candidate" and point.distance_to(origin) > threshold:
		mode = "pan"
	if mode == "pan":
		return {"kind": "pan", "delta": point - previous}
	return {"kind": "none"}

func release(id: int, point: Vector2, inside: bool, cancelled: bool = false) -> Dictionary:
	if not contacts.has(id):
		return {"kind": "none"}
	var tap := mode == "tap_candidate" and contacts.size() == 1 and inside and not cancelled and point.distance_to(origin) <= threshold
	contacts.erase(id)
	if contacts.is_empty():
		mode = "idle"
		return {"kind": "tap", "point": point} if tap else {"kind": "end"}
	# Lifting one finger after pinch NEVER re-arms tap; all contacts must end.
	mode = "cancelled"
	return {"kind": "cancel_selection"}

func cancel() -> void:
	contacts.clear()
	mode = "idle"
