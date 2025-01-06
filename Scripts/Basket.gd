extends CharacterBody2D

@export var x_min: float = 0.0  # Left boundary of the screen
@export var x_max: float = 1700.0  # Right boundary of the screen (adjust based on your screen width)
var dragging: bool = false  # Whether the basket is being dragged
var drag_offset: float = -100  # Offset between the basket and the touch point

func _ready():
	# Dynamically calculate the screen boundaries
	var screen_size = get_viewport().get_visible_rect().size
	x_min = 0
	x_max = screen_size.x
	print("Screen size:", screen_size, "x_min:", x_min, "x_max:", x_max)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# Check if the touch is near the basket
			var touch_area_size = 400  # Adjust to increase or decrease sensitivity
			if abs(event.position.x - position.x) < touch_area_size:
				dragging = true
				drag_offset = event.position.x - position.x  # Calculate the correct offset
				print("Touch started at:", event.position.x, "Basket position:", position.x, "Offset:", drag_offset)
		else:
			dragging = false  # Stop dragging when the touch ends
			print("Touch ended.")

	elif event is InputEventScreenDrag and dragging:
		# Update the basket's position based on drag
		position.x = event.position.x - drag_offset

		# Ensure the basket stays within the screen boundaries
		position.x = clamp(position.x, x_min, x_max)
		print("Dragging: Touch position:", event.position.x, "Basket position:", position.x)

func _process(delta: float):
	# Optional: Clamp the basket's position every frame to ensure it remains within bounds
	position.x = clamp(position.x, x_min, x_max)




