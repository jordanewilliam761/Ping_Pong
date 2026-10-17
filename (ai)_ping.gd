extends CharacterBody2D

@export var speed: float = 200.0
@export var stop_distance: float = 10.0
@export var reaction_time: float = 0.15

@onready var ball: CharacterBody2D = %ball

var target_y: float
var reaction_timer: float = 0.0

var starting_x: float
var starting_y: float


func _ready() -> void:
	starting_x = global_position.x
	starting_y = global_position.y

	target_y = starting_y

	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _physics_process(delta: float) -> void:
	reaction_timer -= delta

	# Is the ball traveling toward the RIGHT paddle?
	var ball_coming_toward_me := ball.velocity.x > 0.0

	if reaction_timer <= 0.0:

		if ball_coming_toward_me:
			# Follow the ball.
			target_y = ball.global_position.y

		else:
			# Ball is moving away, return toward the center.
			target_y = starting_y

		reaction_timer = reaction_time


	var distance_to_target := target_y - global_position.y


	if abs(distance_to_target) > stop_distance:
		velocity.y = sign(distance_to_target) * speed
	else:
		velocity.y = 0.0


	velocity.x = 0.0

	move_and_slide()

	# Never allow horizontal movement.
	global_position.x = starting_x
	velocity.x = 0.0
