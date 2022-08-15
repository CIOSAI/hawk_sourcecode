extends Control

onready var display = $"PixelatedScreen/Viewport/DisplayPanel/PlayerDisplay"

export var bird_vel:Vector2
export var wing:bool
export var feet:float

func _ready():
	MusicPlayer.interpolate_volume(MusicPlayer.BASS, 0.1)
	MusicPlayer.interpolate_volume(MusicPlayer.PANIC, 0.1)

func _process(delta):
	display.set_facing(
		display.FACING.RIGHT 
		if bird_vel.x<0 else 
		display.FACING.LEFT
	)
	display.set_looking(-bird_vel.x)
	display.set_heading(-bird_vel)
	display.wing_open(wing)
	display.set_feet(feet)
	display.set_tail_dir(-bird_vel)

func _input(event):
	if event.is_action_pressed("Flap"):
		Global.set_pixelate(!Global.pixelate)
		SaveLoad.save_data()
		AudioFx.play(AudioFx.CLICK)
	if event.is_action_pressed("Flip"):
		Global.set_music_playing(!Global.music_playing)
		SaveLoad.save_data()
		AudioFx.play(AudioFx.CLICK)
	if event.is_action_pressed("Glide"):
		get_tree().change_scene("res://Scenes/World.tscn")
		AudioFx.play(AudioFx.CLICK)
