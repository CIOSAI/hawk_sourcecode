extends Particles2D

onready var label = $"Viewport/Control/Label"
onready var vp = $"Viewport"

func _ready():
	texture = vp.get_texture()

func fire():
	label.text = ["BRUH", "XD", "UWU", "CAPYBARE", "BABABOOIE"][randi()%5]
	emitting = true
