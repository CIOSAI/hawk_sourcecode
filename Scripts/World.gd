extends Node2D

onready var bloodsplat = preload("res://Scenes/BloodParticle.tscn")
onready var rng = RandomNumberGenerator.new()
onready var bunnies = $"PixelatedScreen/Viewport/Bunnies"
onready var player = $"PixelatedScreen/Viewport/Player"
onready var ground = $"PixelatedScreen/Viewport/Ground"
onready var ui = $"PixelatedScreen/Viewport/UI/UI"
onready var parallax = $"PixelatedScreen/Viewport/ParallaxBackground/ParallaxLayer"
onready var death_screen = $"PixelatedScreen/Viewport/UI/DeathScreen"

export var offset:float
export var spawn_offset:float
export var effective_width:float
export var bunny_amount:int = 64
export var bunny_scene:PackedScene
export var warning_color:Color

var score:int = 0

func _ready():
	MusicPlayer.interpolate_volume(MusicPlayer.BASS, 1)
	
	rng.randomize()
	refresh_bunny()
	
	player.movement.set_physics_process(false)
	yield($"PixelatedScreen/Viewport/Ready", "complete")
	$"PixelatedScreen/Viewport/Ready".hide()
	player.movement.set_physics_process(true)

func _physics_process(delta):
	ground.tile_ground(player.global_position.x)

func _process(delta):
	var dirt_risk:float = pow(clamp(
							(player.global_position.y+1200+max(player.movement.vel.y, 0)
						  )/2400, 0, 1), 0.7)
	
	parallax.modulate = Color.white.linear_interpolate(warning_color, 
		dirt_risk
	)
	MusicPlayer.interpolate_volume(MusicPlayer.PANIC, dirt_risk)
	
	ui.set_height(min(player.global_position.y+720, 0.0))

func player_adjusted_pos()->Vector2:
	return player.global_position + Vector2(
		sign(player.movement.vel.x+0.001)*offset,
		0.0
	)

func blood(v:Vector2):
	var b = bloodsplat.instance()
	b.global_position = v
	$"PixelatedScreen/Viewport".add_child(b)

func remove_bunny(b:Bunny):
	b.queue_free()

func bunny_dies(b:Bunny):
	score += 1
	Global.camera.screen_shake(5)
	blood(b.global_position)
	player.fatten()

func spawn_bunny():
	var x:float = player_adjusted_pos().x+rng.randf_range(-spawn_offset, spawn_offset)
	
	var b:Bunny = bunny_scene.instance()
	b.global_position = Vector2(x, -250)
	b.connect("death", self, "bunny_dies", [b])
	
	bunnies.add_child(b)

func refresh_bunny():
	for i in bunnies.get_children():
		if abs(
			i.global_position.x-player_adjusted_pos().x
			) > effective_width:
				remove_bunny(i)
	
	if bunny_amount-bunnies.get_children().size()>0:
		spawn_bunny()

func _on_SpawnTick_timeout():
	refresh_bunny()

func _on_Player_death():
	player.movement.input_process = false
	Global.camera.screen_shake(10)
	blood(player.global_position)
	death_screen._show(score)
