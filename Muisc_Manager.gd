extends Node

@onready var player = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func play_music(music: AudioStream, volume_db: float = 100.0):
	if player.stream == music:
		AudioServer.set_bus_volume_db(0, 100)
		return # already playing, don't restart
	player.stream = music
	player.volume_db = volume_db
	player.play()
