extends CharacterBody2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var speed: float = 250.0
@export var speed_increase: float = 13.0
@export var max_speed: float = 400.0
@export var max_bounce_angle: float = 75.0

var starting_position: Vector2


func _ready() -> void:
	starting_position = global_position
	launch_ball()


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)

	if collision:
		var collider = collision.get_collider()

		if collider.is_in_group("Paddles"):
			bounce_from_paddle(collider)
		elif collider.is_in_group("Walls"):
			# Only reverse vertical movement
			velocity.y *= -1
			velocity = velocity.normalized() * speed
		else:
			velocity = velocity.bounce(collision.get_normal())
			velocity = velocity.normalized() * speed

		audio_stream_player_2d.play()


func launch_ball() -> void:
	var x_direction: float = [-1.0, 1.0].pick_random()
	var y_direction: float = randf_range(-0.7, 0.7)

	velocity = Vector2(x_direction, y_direction).normalized() * speed


func reset_ball() -> void:
	global_position = starting_position
	speed = 250.0
	launch_ball()


func bounce_from_paddle(paddle: Node2D) -> void:
	var paddle_height: float = 100.0

	var difference_y = global_position.y - paddle.global_position.y

	var normalized_y = difference_y / (paddle_height / 2.0)
	normalized_y = clamp(normalized_y, -1.0, 1.0)

	var angle = deg_to_rad(normalized_y * max_bounce_angle)

	var x_direction: float = -sign(velocity.x)

	speed += speed_increase
	speed = min(speed, max_speed)

	velocity.x = cos(angle) * speed * x_direction
	velocity.y = sin(angle) * speed
