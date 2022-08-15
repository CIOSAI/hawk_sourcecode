extends Node2D

onready var rng = RandomNumberGenerator.new()

var sounds = []

func _ready():
	for i in get_children():
		sounds.append(i)
	
	rng.randomize()

func play():
	sounds[rng.randi()%sounds.size()].play()
