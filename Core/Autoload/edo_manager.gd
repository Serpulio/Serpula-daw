extends Node

func half_to_rate(scale_halfs_count: float, half: float, octave: int = 0) -> float:
	var base_freq: float = 440.0
	var calculated_freq: float = base_freq * pow(2.0, half / scale_halfs_count)
	calculated_freq *= pow(2.0, float(octave))
	
	return calculated_freq
