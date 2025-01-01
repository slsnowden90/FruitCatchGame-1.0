extends Node2D

var score: int = 0
var lives: int = 3

# Dictionary to track how many of each fruit you caught
var fruit_counters := {
	"apple": 0,
	"raspberry": 0,
	"decayed": 0
}

func _ready() -> void:
	# Optional: if you want to set "Score: 0" at start
	update_score_label()
	update_lives_label()

func increment_score(value: int) -> void:
	score += value
	update_score_label()

func lose_life() -> void:
	lives -= 1
	update_lives_label()
	
	if lives <= 0:
		game_over()

func update_lives_label() -> void:
	$UI/LivesLabel.text = "Lives: %d" % lives

func game_over() -> void:
	print("Game Over!")
	Global.final_score = score
	Global.fruit_counters = fruit_counters
	get_tree().change_scene_to_file("res://GameOver.tscn")
	# get_tree().change_scene("res://GameOver.tscn") or
	# get_tree().reload_current_scene()
	
func update_score_label() -> void:
	# Update the text on the label
	$UI/ScoreLabel.text = "Score: %d" % score


func _on_catch_area_body_entered(body):
	# If the body is a decayed fruit
	if body.is_rasp == true:
		fruit_counters["raspberry"] += 1
		
	if body.is_apple == true:
		fruit_counters["apple"] += 1	
		
	if body.is_decayed == true:
		# or if "is_decayed" in body and body.is_decayed == true
		print("This went OFF!")
		lose_life()
		body.queue_free()

	# Otherwise, treat it like normal fruit
	else:
		var points = 1
		
		if "point_value" in body:
			points = body.point_value
				
		increment_score(points)
		body.queue_free()
		
