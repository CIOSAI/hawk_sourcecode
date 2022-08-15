extends Control

onready var hi = $"HeightIndicator"

export(float, 0.0, 1.0) var height_adjust:float

func set_height(y:float):
	hi.value = height_adjust*log(-y)
