extends RigidBody3D

class_name AbstractParriable

@export var repulsion_magnitude: float = 2000
@export var repulsion_torque: float = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func is_parried(parried_by: RigidBody3D) -> void:
	print('PARRIED!')

	apply_force((position - parried_by.position).normalized()*repulsion_magnitude)
	apply_torque(Vector3(1, 0, 0) * repulsion_torque)