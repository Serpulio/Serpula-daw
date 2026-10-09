extends AudioStreamPlayer
class_name AudioEDOPlayer

@export_range(0.0, 1.0) var target_volume: float = 0.2

var frequency: float = 440.0
var target_frequency: float = 440.0
var sample_rate: float = 44100.0
var phase: float = 0.0
var volume: float = 0.2

var playback: AudioStreamGeneratorPlayback

func _ready() -> void:
	if not stream or not stream is AudioStreamGenerator:
		var generator = AudioStreamGenerator.new()
		generator.mix_rate = 44100
		stream = generator
		
	volume = target_volume
	play()
	playback = get_stream_playback() as AudioStreamGeneratorPlayback
	sample_rate = stream.mix_rate
	stop_note()

func _process(_delta: float) -> void:
	_fill_buffer()

func _fill_buffer() -> void:
	if not playback:
		return
		
	var frames: int = playback.get_frames_available()
	
	for i in range(frames):
		frequency = lerpf(frequency, target_frequency, 0.005)
		
		var increment: float = frequency / sample_rate
		var sample: float = sin(phase * TAU) * volume
		
		playback.push_frame(Vector2.ONE * sample)
		phase = fmod(phase + increment, 1.0)

func play_note(target_hz: float, delay: float) -> void:
	volume = target_volume
	target_frequency = target_hz
	
	var safe_delay: float = max(0.01, delay)
	await get_tree().create_timer(safe_delay).timeout
	stop_note()

func stop_note() -> void:
	volume = 0.0
