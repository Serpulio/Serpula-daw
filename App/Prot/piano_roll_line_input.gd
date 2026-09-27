extends HBoxContainer

@export var proll_data: Array[bool]
@export var proll_player: AudioStreamPlayer
@export var drum_samples: Array[AudioStream]
@export var menu_drums_button: OptionButton

@export var proll_sample: AudioStream

func _ready() -> void:
	G.play.connect(_play_proll)
	G.check.connect(_proll_check)
	G.add_lengh.connect(_add_lendgh)
	G.delete_lengh.connect(_delete_lendgh)
	
	for i in get_children():
		if i is AudioStreamPlayer:
			proll_player = i
		
		if i is OptionButton:
			menu_drums_button = i
	
	_proll_check()
	
	if proll_sample:
		$Panel/Label.text = proll_sample.resource_name
		$AudioStreamPlayer.stream = proll_sample

	if menu_drums_button:
		
		for i in drum_samples:
			menu_drums_button.add_item(i.resource_name)

func _play_proll() -> void:
	for i in proll_data:
		if i:
			if !proll_player:
				print(name + " havent audio player")
				return
			proll_player.play()
		
		await get_tree().create_timer(G.time_speed).timeout

func _proll_check() -> void:
	
	var tmp_proll_data: Array[bool]
	
	drum_samples = _get_wav_files()
	
	for i in get_children():
		if i is Button:
			print(i.name + " IS: " + "Pressed" if i.button_pressed else "Dont presed")
			tmp_proll_data.append(i.button_pressed)
	
	proll_player.stream = drum_samples[menu_drums_button.selected]
	
	proll_data = tmp_proll_data

	for i in get_children():
		if i is Button:
			i.mouse_entered.connect(UFX.btn_hover.emit)
			i.pressed.connect(UFX.btn_pressed.emit)

func _add_lendgh() -> void:
	var add: Button = Button.new()
	add.text = "+"
	add.toggle_mode = true
	add_child(add)
	
func _delete_lendgh() -> void:
	
	if get_child(get_child_count() - 1) is Button:
		get_child(get_child_count() - 1).free()



func _get_wav_files() -> Array[AudioStream]:
	var result: Array[AudioStream] = []
	var dir := DirAccess.open(G.drum_samels_path)

	if dir == null:
		push_error("Не удалось открыть папку: " + G.drum_samels_path)
		return result

	dir.list_dir_begin()

	var file_name := dir.get_next()

	while file_name != "":
		if !dir.current_is_dir() and file_name.to_lower().ends_with(".wav"):
			var audio := load(G.drum_samels_path.path_join(file_name)) as AudioStream

			if audio:
				audio.resource_name = file_name.get_basename()
				result.append(audio)

		file_name = dir.get_next()

	dir.list_dir_end()
	return result
