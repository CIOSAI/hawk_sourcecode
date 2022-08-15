extends Node

var camera:PlayerCamera

var pixelate:bool = false
var music_playing:bool = true
var high_score:int = 0

signal pixelate_toggled
signal music_toggled

func set_pixelate(b:bool):
	pixelate = b
	emit_signal("pixelate_toggled")

func set_music_playing(b:bool):
	music_playing = b
	emit_signal("music_toggled")
