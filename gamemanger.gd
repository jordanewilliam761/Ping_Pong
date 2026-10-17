extends Node

var P1score: int = 0
var P2score: int = 0
var AIscore: int = 0

@onready var score_label: Label = $ScoreLabel
@onready var score_label_op: Label = $"ScoreLabel(OP)"
@onready var score_label_ai_: Label = %"ScoreLabel(AI)"


func P1_add_point():
	P1score += 1
	score_label.text = str(P1score)
	
	
func P2_add_point():
	P2score += 1
	score_label_op.text = str(P2score)
func Ai_add_point():
	AIscore += 1
	score_label_ai_.text = str(AIscore)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
