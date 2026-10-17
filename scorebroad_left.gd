extends Area2D

@onready var timer: Timer = $Timer
@onready var gamemanager: Node = %gamemanger
@onready var ball: CharacterBody2D = %ball
@onready var p1_ping: CharacterBody2D = %"(P1) ping"
@onready var p2_ping: CharacterBody2D = %"(P2) ping 2"

var already_scored := false
var p1_starting_position: Vector2
var p2_starting_position: Vector2


func _ready() -> void:
	timer.process_mode = Node.PROCESS_MODE_ALWAYS

	p1_starting_position = p1_ping.global_position
	p2_starting_position = p2_ping.global_position


func _on_body_entered(body: Node2D) -> void:
	if already_scored:
		return

	if body == ball:
		already_scored = true
		print("Scored")
		gamemanager.P2_add_point()

		get_tree().paused = true
		timer.start()


func _on_timer_timeout() -> void:
	ball.reset_ball()

	p1_ping.global_position = p1_starting_position
	p2_ping.global_position = p2_starting_position

	already_scored = false
	get_tree().paused = false
