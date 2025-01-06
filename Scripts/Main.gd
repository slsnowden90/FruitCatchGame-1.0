extends Node2D

var score: int = 0
var lives: int = 3

# Dictionary to track how many of each fruit you caught
var fruit_counters := {
	"Apple": 0,
	"Raspberry": 0,
	"Watermelon": 0,
	"Decayed_pear": 0
}


func _ready() -> void:
	var texture_rect = $TextureRect  # Reference the TextureRect node
	var texture = texture_rect.texture

	if texture == null:
		print("No texture assigned to the TextureRect node!")
		return

	var screen_size = get_viewport().get_visible_rect().size
	var texture_size = texture.get_size()

	# Debugging: Log sizes
	print("Screen size:", screen_size)
	print("Texture size:", texture_size)

	# TextureRect already handles scaling if Stretch Mode is set to Cover
	

func increment_score(value: int) -> void:
	score += value
	update_score_label()

func lose_life() -> void:
	lives -= 1
	update_lives_label()
	if lives <= 0:
		game_over()
	
func gain_life() -> void:
	if lives < 3:
		lives += 1
	update_lives_label()
	

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
		fruit_counters["Raspberry"] += 1
		
	if body.is_apple == true:
		fruit_counters["Apple"] += 1	
		
	if body.is_water == true:
		fruit_counters["Watermelon"] += 1	
	
		
	if body.is_decayed == true:
		# or if "is_decayed" in body and body.is_decayed == true
		print("This went OFF!")
		fruit_counters["Decayed_pear"] += 1	
		lose_life()
		body.queue_free()

	# Otherwise, treat it like normal fruit
	else:
		var points = 1
		
		if "point_value" in body:
			points = body.point_value
				
		increment_score(points)
		body.queue_free()
	
	if body.is_water == true and score > 100:
		print("You Just Caught a watermelon")
		gain_life()
		print("You just gained a life")
		body.queue_free()
		
