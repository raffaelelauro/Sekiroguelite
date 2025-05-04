extends RigidBody3D

class_name Enemy

@export var speed: float = 10.0
@export var target: Node3D
var stop: bool = false
	
func _process(delta: float) -> void:
	if !stop and target != null and !position.is_equal_approx(target.position):
		look_at(target.position)
		position = position.move_toward(target.position, delta*speed)
	
func is_parried() -> void:
	print('PARRIED!')
	stop = true
	rotation.x = PI/2
	
	apply_force((position - target.position).normalized()*1000)

func _on_body_entered(body:Node) -> void:
	print("EXPLOSION")
