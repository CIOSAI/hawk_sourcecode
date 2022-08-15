extends Control

onready var notch = $"TextureRect"

var value:float = 0.0

var size:float

func _ready():
	size = $"NinePatchRect".rect_size.y

func _process(delta):
	value = clamp(value, 0.0, 1.0)
	display_value()

func display_value():
	notch.rect_position.y = (1.0-value)*size
