extends Node2D

export var offset:float
export var force:float
export var drop_size:float

onready var drop = $"BloodDrops/BloodDrop"
onready var blood_drops = $"BloodDrops"

func _ready():
	randomize()
	
	for i in 11:
		var d = drop.duplicate()
		blood_drops.add_child(d)
	
	for i in blood_drops.get_children():
		i.get_node("Sprite").scale = Vector2.ONE*randf()*drop_size
		i.apply_impulse(
			Vector2(
				rand_range(-offset, offset), 
				rand_range(-offset, offset)
			),
			Vector2.UP.rotated(rand_range(-0.5, 0.5))*randf()*force
		)

func _on_Timer_timeout():
	queue_free()
