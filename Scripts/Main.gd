extends Node2D

var score: int = 0
var lives: int = 3

func _ready() -> void:
	# Optional: if you want to set "Score: 0" at start
	update_score_label()

func increment_score(value: int) -> void:
	score += value
	update_score_label()

func update_score_label() -> void:
	# Update the text on the label
	$UI/ScoreLabel.text = "Score: %d" % score


func _on_catch_area_body_entered(body):
	# Default to 1 in case it's some other object without point_value
	var points = 1

	# Check if 'point_value' is defined on the caught body
	if "point_value" in body:
		points = body.point_value

	increment_score(points)
	body.queue_free()
