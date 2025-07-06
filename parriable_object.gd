extends AbstractParriable

@export var initial_impulse_magnitude: float = 750
@export var initial_impulse_direction: Vector3 = Vector3(-1, 0, 0)
@export var destroy_distance: float = 20 

func _ready() -> void:
	super._ready()
	apply_force(initial_impulse_direction * initial_impulse_magnitude)
	
	
func _physics_process(_delta: float) -> void:
	if get_global_position().length() >= destroy_distance :
		destroy_self()