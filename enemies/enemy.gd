extends AbstractParriable

class_name Enemy

@export var speed: float = 1000.0
@export var target: Node3D
var stop: bool = false
	
func _physics_process(delta: float) -> void:
	if !stop and target != null and !global_position.is_equal_approx(target.global_position):
		look_at(target.global_position)
		apply_force((target.global_position-global_position).normalized() * delta * speed)
		
func is_parried(parried_by: RigidBody3D) -> void:
	super.is_parried(parried_by)
	stop = true

# Detect collision with AbstractParriable
func _on_body_entered(body: Node) -> void:
	print("HIT")
	if body is AbstractParriable:
		var body_parriable_object: AbstractParriable = body as AbstractParriable
		body_parriable_object.collision_hit()
		self.destroy_self()
