extends VBoxContainer

const PROLL_LINE = preload("uid://dlkh3qf61stho")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.add_line.connect(_add_line)
	G.delete_line.connect(_delete_line)

func _add_line() -> void:
	var add := PROLL_LINE.instantiate()
	add_child(add)
	
func _delete_line() -> void:
	if get_child(get_child_count() - 1):
		get_child(get_child_count() - 1).free()
	
