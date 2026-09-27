extends GridContainer

@onready var button: Button = $Button
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4
@onready var button_5: Button = $Button5
@onready var button_6: Button = $Button6

func _ready() -> void:
	button.pressed.connect(G.check.emit)
	button_2.pressed.connect(G.play.emit)
	button_3.pressed.connect(G.add_lengh.emit)
	button_4.pressed.connect(G.delete_lengh.emit)
	button_5.pressed.connect(G.add_line.emit)
	button_6.pressed.connect(G.delete_line.emit)
	
	for i in get_children():
		if i is Button:
			i.mouse_entered.connect(UFX.btn_hover.emit)
			i.pressed.connect(UFX.btn_pressed.emit)
