extends Node

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $Animation

var countdown = 3

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

	label.text = str(countdown)
	timer.start()


func _on_timer_timeout():
	print("timer working")

	countdown -= 1

	if countdown > 0:
		label.text = str(countdown)

	else:
		timer.stop()
		label.text = "GO!"

		animation_player.play("disapper")
		await animation_player.animation_finished

		get_tree().paused = false
		queue_free()
