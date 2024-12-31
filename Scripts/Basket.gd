extends CharacterBody2D

@export var move_speed: float = 700.0
@export var x_min: float = -600.0
@export var x_max: float = 600.0

func _physics_process(delta: float) -> void:
	# Clear any previous horizontal velocity
	velocity.x = 0.0

	# Check arrow key input
	if Input.is_action_pressed("ui_left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = move_speed

	# Use move_and_slide() without assigning its return value
	# In Godot 4, CharacterBody2D automatically uses 'velocity' as the movement vector
	move_and_slide()

	# Optionally clamp the X position so the basket doesn't leave the screen
	position.x = clamp(position.x, x_min, x_max)

