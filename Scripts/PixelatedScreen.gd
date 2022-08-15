extends ViewportContainer

func _ready():
	refresh()
	Global.connect("pixelate_toggled", self, "refresh")

func refresh():
	material.set_shader_param("DownScale", 4 if Global.pixelate else 1)
