extends RigidBody3D

class_name Enemy

@export var speed: float = 1000.0
@export var target: Node3D
@export var repulsion_magnitude: float = 2000
@export var repulsion_torque: float = 1000
var stop: bool = false
	
func _physics_process(delta: float) -> void:
	if !stop and target != null and !position.is_equal_approx(target.position):
		look_at(target.position)
		apply_force((target.position-position).normalized() * delta * speed)
	
func is_parried() -> void:
	print('PARRIED!')
	stop = true
	
	apply_force((position - target.position).normalized()*repulsion_magnitude)
	apply_torque(Vector3(1, 0, 0) * repulsion_torque)
