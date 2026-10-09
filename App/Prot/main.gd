extends VBoxContainer

@export var note_scale: Note_Scale
@onready var half_values: VBoxContainer = $Top/ScrollHalfValues/HalfValues
@onready var halfs_cout: LineEdit = $Top/HalfsCout

func setup() -> Note_Scale:
	var res := Note_Scale.new()
	if !half_values.has_method("_get_flats"):
		return res
	if halfs_cout.text.is_valid_int():
		res.halfs = (halfs_cout.text).to_int()
	
	var flats: Array[int] = half_values._get_flats()
	res.scale_halfs = flats
	return res

func _ready() -> void:
	pass
