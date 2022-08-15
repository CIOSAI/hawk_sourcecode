extends Control

onready var bloop:AudioStreamPlayer = $"Bloop"

signal complete

func check():
	Global.camera.screen_shake(3)
	var pressed:int = 0
	for i in $"VBoxContainer".get_children():
		if !i.visible: pressed += 1
	bloop.pitch_scale = 1+pressed*0.1
	bloop.play()
	if pressed==3: emit_signal("complete")

func _input(event):
	if visible:
		if Input.is_action_just_pressed("Flap"):
			$"VBoxContainer/Flap".hide()
			check()
		if Input.is_action_just_pressed("Glide"):
			$"VBoxContainer/Glide".hide()
			check()
		if Input.is_action_just_pressed("Flip"):
			$"VBoxContainer/Turn".hide()
			check()
