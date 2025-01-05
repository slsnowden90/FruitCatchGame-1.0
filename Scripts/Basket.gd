extends CharacterBody2D

@export var speed: float = 700.0  # Movement speed
var x_min: float = -600.0  # Left boundary of the screen
var x_max: float = 1500.0   # Right boundary of the screen

func _ready():
	# Debugging: Log the desired boundaries
	print("x_min:", x_min, "x_max:", x_max)


func _physics_process(delta: float):
	# Handle movement with keyboard or touch buttons
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_left_arrow"):
		direction.x -= 1
	if Input.is_action_pressed("move_right_arrow"):
		direction.x += 1

	# Normalize direction and calculate velocity
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	# Ensure the basket stays within the screen boundaries
	position.x = clamp(position.x, x_min, x_max)

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		# Get the touch position
		var touch_pos = event.position

		# Debugging: Log the touch position
		print("Touch detected at X:", touch_pos.x)
		
		# Map touch position to the desired range
		var screen_width = get_viewport().get_visible_rect().size.x
		var mapped_x = lerp(-600.0, 1300.0, touch_pos.x / screen_width)

		# Debugging: Log the mapped touch position
		print("Mapped X:", mapped_x)

		# Move the basket directly to the mapped position
		position.x = clamp(mapped_x, x_min, x_max)
		print("Basket moved to X:", position.x)
