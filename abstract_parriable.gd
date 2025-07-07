extends RigidBody3D

class_name AbstractParriable

@export var repulsion_magnitude: float = 2000
@export var repulsion_torque: float = 1000
@export var destroy_on_parry_delay: float = 3

var destroy_timer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	destroy_timer = Timer.new()
	destroy_timer.wait_time = destroy_on_parry_delay
	destroy_timer.timeout.connect(destroy_self)
	add_child(destroy_timer)

func is_parried(parried_by: RigidBody3D) -> void:
	print('PARRIED!')

	apply_force((position - parried_by.position).normalized()*repulsion_magnitude)
	apply_torque(Vector3(1, 0, 0) * repulsion_torque)
	
	destroy_timer.start()
	
func collision_hit() -> void:
	self.destroy_self()
	
func destroy_self() -> void:
	print("Destroying " + self.get_name())
	queue_free()
	
