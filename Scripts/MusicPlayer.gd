extends Node

enum {
	MAIN = 4, 
	PANIC = 3, 
	BASS = 2
}

onready var tw = $"Tween"
onready var loops = {
	MAIN = $"MainLoop",
	PANIC = $"Panic",
	BASS = $"Bass"
}

func _ready():
	refresh()
	Global.connect("music_toggled", self, "refresh")

func refresh():
	AudioServer.set_bus_volume_db(1, linear2db(
		1 if Global.music_playing else 0
	))

func interpolate_volume(i:int, v:float):
	AudioServer.set_bus_volume_db(i, linear2db(v))
