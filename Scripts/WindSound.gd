extends AudioStreamPlayer

export var lower_range:float
export var higher_range:float

func level(v:float):
	var bp:AudioEffectBandPassFilter = AudioServer.get_bus_effect(5, 0)
	
	bp.cutoff_hz = lerp(lower_range, higher_range, v)
