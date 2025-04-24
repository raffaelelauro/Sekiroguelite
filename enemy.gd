extends RigidBody3D

@export var speed: float = 10.0
@export var target: Node3D

	
func _process(delta: float) -> void:
	if target != null :
		position = position.move_toward(target.position, delta*speed)
