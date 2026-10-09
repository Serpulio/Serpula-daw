extends Panel

@export var octav: int 
@export var half_time: float 
@export var note_scale: Note_Scale

@onready var edo_player: AudioEDOPlayer = $AudioEDOPlayer

@onready var halfs_cout: LineEdit = $Main/Top/HalfsCout
@onready var half_values: VBoxContainer = $Main/Top/ScrollHalfValues/HalfValues

@onready var line_time: LineEdit = $Main/Bottom/GridContainer/LineTime
@onready var line_octave: LineEdit = $Main/Bottom/GridContainer/LineOctave
@onready var main: VBoxContainer = $Main

@onready var reset: Button = $Main/Bottom/Reset
@onready var play_toggle: Button = $Main/Bottom/PlayToggle

var halfs: float = 12
var fstep: int = 0 

func reset_all() -> void:
	note_scale = main.setup()

func on_playing() -> void:
	for ns in note_scale.scale_halfs:
		edo_player.play_note(EDOManager.half_to_rate(note_scale.halfs, ns, 3), 1)
		await get_tree().create_timer(0.3).timeout
	

func _ready():
	reset.pressed.connect(reset_all)
	play_toggle.pressed.connect(on_playing)
	halfs = note_scale.halfs
