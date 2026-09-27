extends Node


@export_category("Buttons")
@export var button_hover_sample: AudioStream = preload("uid://b7uqqgfrtj6gr")
@export var button_pressed_sample: AudioStream = preload("uid://0x4chntdxl0e")

signal btn_hover
signal btn_pressed

func _ready() -> void:
	_make_children()
	
	btn_hover.connect(btn_hover_play)
	btn_pressed.connect(btn_pressed_play)

func btn_hover_play() -> void:
	if !button_hover_sample:
		print("btn hover has no sound")
		return
	if !$btn_hover_asp:
		print("not audio stream for playing hover sound")
		return
		
	$btn_hover_asp.play()
	

func btn_pressed_play() -> void:
	if !button_pressed_sample:
		print("btn pressed has no sound")
		return
	if !$btn_pressed_asp:
		print("not audio stream for playing pressed sound")
		return
		
	$btn_pressed_asp.play()


func _make_children() -> void:
	var btn_hover_asp = AudioStreamPlayer.new()
	btn_hover_asp.stream = button_hover_sample
	btn_hover_asp.name = "btn_hover_asp"
	add_child(btn_hover_asp)

	var btn_pressed_asp = AudioStreamPlayer.new()
	btn_pressed_asp.stream = button_pressed_sample
	btn_pressed_asp.name = "btn_pressed_asp"
	add_child(btn_pressed_asp)
