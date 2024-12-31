extends RigidBody2D

@export var point_value: int = 5  # Default 1 point
@export var min_gravity: float = 0.1
@export var max_gravity: float = 2.0

func _ready() -> void:
	gravity_scale = randf_range(min_gravity, max_gravity)

# If you want to detect collisions with the basket here:
func _on_Fruit_body_entered(body: Node) -> void:
	if body.name == "Basket":
		# Increase score, etc.
		queue_free()
