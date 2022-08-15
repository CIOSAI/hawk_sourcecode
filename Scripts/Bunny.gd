extends KinematicBody2D
class_name Bunny

onready var movement = $"BunnyMovement"
onready var display = $"BunnyDisplay"
onready var blood_sounds = $"BloodSounds"
onready var crush_sounds = $"CrushSounds"

export var blood_color:Color

signal death

func death():
	blood_sounds.play()
	crush_sounds.play()
	$"HurtArea".disconnect("body_entered", self, "_on_HurtArea_body_entered")
	movement.disconnect("hop", self, "_on_BunnyMovement_hop")
	movement.jump_force = Vector2.ZERO
	display.modulate = blood_color

func _on_HurtArea_body_entered(body):
	emit_signal("death")
	death()

func _process(delta):
	display.set_facing(movement.dir)

func _on_BunnyMovement_hop():
	display.hop()
