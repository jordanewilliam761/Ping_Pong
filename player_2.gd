extends CharacterBody2D

@export var speed: float = 300.0

var starting_x: float

func _ready() -> void:
	starting_x = global_position.x
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("(P2) up", "(P2) down")

	velocity = Vector2(0.0, direction * speed)

	move_and_slide()

	# Keep the paddle from moving left or right.
	global_position.x = starting_x
	velocity.x = 0.0
