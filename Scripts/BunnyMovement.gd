extends Node2D

onready var timer = $"Timer"

export var jump_force:Vector2
export(float, 0.0, 1.0) var fric:float
export var gravity:float
export var body_path:NodePath

var vel:Vector2 = Vector2.ZERO
var dir:float = 1.0
var body:KinematicBody2D

signal hop

func _ready():
	body = get_node(body_path)
	randomize()
	dir = sign(rand_range(-1.0, 1.0))
	timer.wait_time = rand_range(0.6, 1.2)

func move():
	if body.is_on_floor():
		vel.y = min(vel.y, 0.0)
		vel.x *= (1.0-fric)
	
	vel.y += gravity

func _physics_process(delta):
	move()
	
	body.move_and_slide(vel, Vector2.UP)

func _on_Timer_timeout():
	emit_signal("hop")
	vel += jump_force*Vector2(dir, -1.0)
