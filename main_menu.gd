extends Control

@onready var press_r: AudioStreamPlayer2D = $Main_menu/VBoxContainer/P1vP2/pressR
@export var music: AudioStream



var changing_scene: bool = false


func _ready() -> void:
	# Make sure the menu is not paused after returning from a game.
	get_tree().paused = false
	changing_scene = false


func _on_p_1v_p_2_pressed() -> void:
	change_to_scene("res://level.tscn")


func _on_p_1vai_pressed() -> void:
	change_to_scene("res://level_vs_ai.tscn")


func change_to_scene(scene_path: String) -> void:
	# Prevent the player from pressing buttons multiple times.
	if changing_scene:
		return

	changing_scene = true

	if press_r:
		press_r.play()

	await get_tree().create_timer(0.2).timeout

	var error := get_tree().change_scene_to_file(scene_path)

	if error != OK:
		print("Could not change scene. Error code: ", error)
		changing_scene = false


func _on_exit_pressed() -> void:
	if changing_scene:
		return

	changing_scene = true

	if press_r:
		press_r.play()

	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
