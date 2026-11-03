extends RefCounted
## One versioned presentation envelope; transient selections/contacts are never saved.

var path := "user://state_v1.json"
var write_blocked := false

func valid_envelope(value: Variant) -> bool:
	return value is Dictionary and value.get("schema_version") == 1 and value.get("app_version") == "0.0.1-m0.1" and value.get("active_view") in ["kingdom", "region_1"] and value.get("cameras") is Dictionary

func read_file(file_path: String) -> Variant:
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return null
	var parser := JSON.new()
	if parser.parse(file.get_as_text()) != OK:
		return null
	return parser.data

func load_state() -> Dictionary:
	if not FileAccess.file_exists(path):
		# A temp file is an uncommitted write; leave it alone.
		return {"status": "missing", "data": {}}
	var value: Variant = read_file(path)
	if valid_envelope(value):
		return {"status": "ok", "data": value}
	# Never destroy an unsupported/corrupt primary by auto-saving defaults.
	write_blocked = true
	var backup: Variant = read_file(path + ".bak")
	if valid_envelope(backup):
		return {"status": "recovered", "data": backup}
	return {"status": "blocked", "data": {}}

func save_state(value: Dictionary) -> Error:
	if write_blocked or not valid_envelope(value):
		return ERR_INVALID_DATA
	if FileAccess.file_exists(path) and not valid_envelope(read_file(path)):
		write_blocked = true
		return ERR_INVALID_DATA
	var file := FileAccess.open(path + ".tmp", FileAccess.WRITE)
	if file == null:
		return FileAccess.get_open_error()
	file.store_string(JSON.stringify(value))
	file.flush()
	var error := file.get_error()
	file.close()
	if error != OK:
		return error
	var absolute := ProjectSettings.globalize_path(path)
	if FileAccess.file_exists(path):
		error = DirAccess.copy_absolute(absolute, absolute + ".bak")
		if error != OK:
			return error
	return DirAccess.rename_absolute(absolute + ".tmp", absolute)
