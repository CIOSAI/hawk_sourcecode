extends Node

enum {CLICK}
onready var sounds = [$"Click"]

func play(s:int):
	sounds[s].play()
