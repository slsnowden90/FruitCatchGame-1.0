extends Area2D

@export var lives: int = 5

func lose_life() -> void:
	lives -= 1
	update_lives_label()

func _on_CatchArea_body_entered(body: Node) -> void:
	# Check if it's a fruit
	
	if body is RigidBody2D:  # or however you detect
		# 1) Grab the fruit's point value
		var fruit_points = 1
		if "point_value" in body:
			fruit_points = body.point_value
		
		print("Caught body name: ", body.name)
		
		if body.is_decayed == true:
			lose_life()
			body.queue_free()
			
		
		# 2) Add that to your game's score
		var main_node = get_tree().get_root().get_node("Main")  # or however you store your score
		if main_node:
			main_node.increment_score(fruit_points)

		# 3) Remove the fruit
		body.queue_free()
		
func update_lives_label() -> void:
	$UI/LivesLabel.text = "Lives: %d" % lives



