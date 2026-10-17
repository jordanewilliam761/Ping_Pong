extends Control
@onready var press_r: AudioStreamPlayer2D = $ColorRect/Restart/pressR

@onready var gamemanger: Node = %gamemanger


func _ready() -> void:
	hide()


func _process(_delta: float) -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	gamewin()


func gamewin() -> void:
	if gamemanger.AIscore >= 7:
		show()
		get_tree().paused = true


func _on_restart_pressed() -> void:
	get_tree().paused = false
	press_r.play()
	# Reset both scores before restarting.
	gamemanger.AIscore = 0
	gamemanger.P1score = 0
	gamemanger.P2score = 0

	await get_tree().create_timer(0.2).timeout
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().paused = false
	press_r.play()
	
	await get_tree().create_timer(0.2).timeout

	get_tree().change_scene_to_file("res://main_menu.tscn")
