extends Control

@onready var press_r: AudioStreamPlayer2D = $NinePatchRect/VBoxContainer/Restart/pressR
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	animation_player.play("RESET")


func resume() -> void:
	get_tree().paused = false
	animation_player.play_backwards("blur")

	await animation_player.animation_finished
	hide()


func pause() -> void:
	show()
	animation_player.play("blur")
	get_tree().paused = true


func keypause() -> void:
	if Input.is_action_just_pressed("pause"):

		if get_tree().get_first_node_in_group("countdown") != null:
			return

		if get_tree().paused:
			resume()
		else:
			pause()


func _on_exit_pressed() -> void:
	get_tree().paused = false
	press_r.play()

	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().paused = false
	press_r.play()

	await get_tree().create_timer(0.2).timeout
	get_tree().reload_current_scene()


func _process(_delta: float) -> void:
	keypause()
