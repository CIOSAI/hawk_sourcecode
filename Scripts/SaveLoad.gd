extends Node

const data_dir:String = "user://data.save"

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(data_dir, File.WRITE_READ)
	file.store_var(Global.pixelate)
	file.store_var(Global.music_playing)
	file.store_var(Global.high_score)
	file.close()

func load_data():
	var file = File.new()
	if file.file_exists(data_dir):
		file.open(data_dir, File.READ)
		Global.pixelate = bool(file.get_var())
		Global.music_playing = bool(file.get_var())
		Global.high_score = int(file.get_var())
		file.close()
	else:
		save_data()
