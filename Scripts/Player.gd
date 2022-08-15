extends KinematicBody2D
class_name Player

onready var movement = $"PlayerMovement"
onready var display = $"PlayerDisplay"
onready var camera = $"Stick/PlayerCamera"
onready var tw = $"Tween"
onready var crush_sounds = $"CrushSounds"
onready var grass_sounds = $"GrassSound"
onready var wing_flaps = $"WingFlap"
onready var turn_sound = $"TurnSound"
onready var wind_sound = $"WindSound"

export(float, 0.0, 1.0) var tail_lerp:float

var prev_vel:Vector2 = Vector2.ZERO

signal death

func _ready():
	Global.camera = camera

func get_speed():
	return clamp(pow(movement.vel.length()/14000.0, 0.6), 0.0, 1.0)

func get_accel():
	return clamp(pow(movement.get_acceleration().length()/500.0, 0.25), 0.0, 1.0)

func _process(delta):
	display.set_facing(
		display.FACING.RIGHT 
		if movement.vel.x<0 else 
		display.FACING.LEFT
	)
	display.set_looking(-movement.vel.x)
	display.set_heading(-movement.vel)
	display.wing_open(movement.glide_dive)
	display.set_feet(clamp(get_speed()*2.0, 0.0, 1.0))
	display.set_tail_dir(-prev_vel)
	prev_vel = lerp(prev_vel, movement.vel, tail_lerp)
	
	tw.interpolate_property($"Stick", "position", 
		$"Stick".position, (
			(movement.vel+Vector2(0, get_speed()/2)
			).normalized()
		*(get_speed()*600) 
		),
		1.5, Tween.TRANS_QUART, Tween.EASE_OUT)
	tw.start()
	camera.zoom_to(1+get_speed()*3)
	
	wind_sound.level(pow(get_speed(), 2))

func fatten():
	movement.gravity += 1
	movement.hori_friction *= 1.01
	
	display.body.get_node("Body").scale.x += 0.01

func _on_Timer_timeout():
	if movement.flapping:
		wing_flaps.play()
		display.wing_flap()

func _on_HurtArea_body_entered(body):
	crush_sounds.play()
	grass_sounds.play()
	emit_signal("death")

func _on_PlayerMovement_turn():
	turn_sound.play()
