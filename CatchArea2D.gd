extends Area2D

func _on_CatchArea_body_entered(body: Node) -> void:
	# Check if it's a fruit
	if body is RigidBody2D:  # or however you detect
		# 1) Grab the fruit's point value
		var fruit_points = 1
		if "point_value" in body:
			fruit_points = body.point_value
		
		# 2) Add that to your game's score
		var main_node = get_tree().get_root().get_node("Main")  # or however you store your score
		if main_node:
			main_node.increment_score(fruit_points)

		# 3) Remove the fruit
		body.queue_free()



