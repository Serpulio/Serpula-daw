extends VBoxContainer


@onready var add_half: Button = %AddHalf
@onready var remove_half: Button = %RemoveHalf

func _ready() -> void:
	add_half.pressed.connect(_add_half)
	remove_half.pressed.connect(_remove_half)

func _get_flats() -> Array[int]:
	var flats: Array[int]
	
	for i in get_children():
		if i is LineEdit:
			if i.text.is_valid_int():
				flats.append((i.text).to_int())
	
	return flats

func _add_half() -> void:
	var nev_half_value := LineEdit.new()
	nev_half_value.alignment = HORIZONTAL_ALIGNMENT_CENTER
	nev_half_value.placeholder_text = "Half Value"
	add_child(nev_half_value)

func _remove_half() -> void:
	if get_child_count() <= 1:
		return
	get_child(get_child_count()-1).free()
