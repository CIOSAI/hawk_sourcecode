extends Control

onready var score_tag:Label = $"Tags/ScoreTag/Score"
onready var record_tag:Label = $"Tags/HighRecordTag/HighRecord"
onready var vegan_tag:Label = $"Tags/VeganTag/Vegan"
onready var retry_button:Button = $"Buttons/Retry"
onready var quit_button:Button = $"Buttons/Quit"

var button_registering:bool = false

func _show(sc:int):
	Global.high_score = max(Global.high_score, sc)
	
	button_registering = false
	$"Buttons".hide()
	
	score_tag.text = "%03d" % sc
	record_tag.text = "%03d" % Global.high_score
	vegan_tag.text = "%03d" % [420, 69][randi()%2]
	
	.show()
	
	yield(get_tree().create_timer(1), "timeout")
	button_registering = true
	$"Buttons".show()

func _hide():
	.hide()

func _input(event):
	if button_registering:
		if event.is_action_pressed("Glide"):
			get_tree().reload_current_scene()
			AudioFx.play(AudioFx.CLICK)
		if event.is_action_pressed("Flip"):
			get_tree().change_scene("res://Scenes/Start.tscn")
			AudioFx.play(AudioFx.CLICK)
