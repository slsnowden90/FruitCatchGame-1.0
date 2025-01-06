extends RigidBody2D

@export var min_gravity: float = 0.1
@export var max_gravity: float = 2.0
@export var point_value: int = 1  # Default 1 point
@export var is_decayed: bool = false
@export var is_rasp: bool = false
@export var is_apple: bool = true
@export var is_water: bool = false

@export var base_speed: float = 50.0  # Initial falling speed
var current_speed: float = base_speed

func _ready():
	# Apply initial velocity
	apply_central_impulse(Vector2(0, current_speed))

func adjust_speed(speed_multiplier: float):
	# Increase the speed dynamically
	current_speed *= speed_multiplier
	linear_velocity = Vector2(0, current_speed)
