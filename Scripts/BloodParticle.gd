extends Particles2D

func _ready():
	emitting = true
	$"Burst".emitting = true

func _on_Timer_timeout():
	queue_free()
