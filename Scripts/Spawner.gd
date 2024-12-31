extends Node2D

@export var fruit_scenes: Array[PackedScene]        # e.g. [Apple.tscn, Banana.tscn, Watermelon.tscn]
@export var spawn_interval: float = 0.5
@export var x_min: float = 0
@export var x_max: float = 1200.0
@export var min_fruits_per_spawn: int = 1
@export var max_fruits_per_spawn: int = 6

var timer: float = 0.0

func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= spawn_interval:
		spawn_fruit_burst()
		timer = 0.0

func spawn_fruit_burst() -> void:
	if fruit_scenes.is_empty():
		print("No fruit scenes assigned!")
		return

	var count = randi() % (max_fruits_per_spawn - min_fruits_per_spawn + 1) + min_fruits_per_spawn
	# e.g. between 1 and 6 inclusive.

	for i in range(count):
		# Randomly pick one fruit scene
		var chosen_scene = fruit_scenes[randi() % fruit_scenes.size()]
		print("Chosen scene is: ", chosen_scene)
		# Instantiate the chosen fruit
		var fruit_instance = chosen_scene.instantiate()

		# Position fruit randomly in the x-range
		var random_x = randf_range(x_min, x_max)
		fruit_instance.position = Vector2(random_x, position.y)

		# Optionally set random gravity, or do other per-fruit customization here
		# (e.g., if fruit is RigidBody2D, you could do fruit_instance.gravity_scale = randf_range(0.5, 2.0))

		add_child(fruit_instance)

	print("Spawned", count, "fruits at once!")


