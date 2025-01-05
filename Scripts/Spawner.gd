extends Node2D

@export var spawn_interval: float = 1.5
@export var x_min: float = 0.0
@export var x_max: float = 1700.0

@export var fruits_info: Array[Dictionary] = [
	{
		"scene": preload("res://Fruit.tscn"),
		"chance": 0.6,
		"min_score": 0
	},
	{
		"scene": preload("res://rasp_scene.tscn"),
		"chance": 0.4,
		"min_score": 0
	},
	{
		"scene": preload("res://WaterMelon.tscn"),
		"chance": 0.1,
		"min_score": 50,
		"is_watermelon": true
	},
	{
		"scene": preload("res://decay_pear.tscn"),
		"chance": 0.7,
		"min_score": 0
	}
]

# Variables for normal spawn logic
var timer: float = 0.0

# Variables to limit watermelons per score bracket
var watermelons_spawned_in_bucket: int = 0
var last_score_bucket: int = 0
@export var watermelons_per_100_points: int = 1  # e.g., 2 per bracket

func _physics_process(delta: float) -> void:
	timer += delta

	# GET the current score from Main
	var main_node = get_tree().get_root().get_node("Main")
	var current_score = 0
	if main_node and "score" in main_node:
		current_score = main_node.score

	# DETERMINE which 100-point bucket we're in
	var score_bucket = int(current_score / 100)  # e.g. 0.. for 0-99, 1.. for 100-199, etc.

	# IF we moved into a new bracket, reset the watermelon count
	if score_bucket != last_score_bucket:
		watermelons_spawned_in_bucket = 0
		last_score_bucket = score_bucket

	# Check if it's time to spawn
	if timer >= spawn_interval:
		spawn_fruit_burst(current_score)
		timer = 0.0

func spawn_fruit_burst(current_score: int) -> void:
	if fruits_info.is_empty():
		print("No fruit data assigned!")
		return

	# For a simple approach, spawn a random batch size, e.g. 1..3
	var min_spawn = 1
	var max_spawn = 3
	var count = randi() % (max_spawn - min_spawn + 1) + min_spawn

	for i in range(count):
		var chosen_scene: PackedScene = pick_fruit_scene(current_score)
		if chosen_scene:
			var fruit_instance = chosen_scene.instantiate()

			# Position fruit randomly
			var random_x = randf_range(x_min, x_max)
			fruit_instance.position = Vector2(random_x, position.y)

			add_child(fruit_instance)

	print("Spawned", count, "fruits at once!")

func pick_fruit_scene(current_score: int) -> PackedScene:
	var valid_fruits: Array[Dictionary] = []

	# Filter fruits by min_score and the watermelon cap
	for fruit_data in fruits_info:
		if current_score >= fruit_data["min_score"]:
			# If it's a watermelon, check cap
			if fruit_data.has("is_watermelon") and fruit_data["is_watermelon"] == true:
				if watermelons_spawned_in_bucket < watermelons_per_100_points:
					valid_fruits.append(fruit_data)
				else:
					# Skip watermelon if we've hit the cap in this bracket
					pass
			else:
				# Normal fruit
				valid_fruits.append(fruit_data)

	if valid_fruits.is_empty():
		return null

	# Weighted random pick
	var total_chance = 0.0
	for vf in valid_fruits:
		total_chance += vf["chance"]

	var rand_val = randf() * total_chance
	for vf in valid_fruits:
		rand_val -= vf["chance"]
		if rand_val <= 0:
			# If it's watermelon, increment the spawn count
			if vf.has("is_watermelon") and vf["is_watermelon"] == true:
				watermelons_spawned_in_bucket += 1
			return vf["scene"]

	return valid_fruits[0]["scene"]
