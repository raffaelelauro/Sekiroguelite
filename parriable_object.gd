extends AbstractParriable

@export var initial_impulse_magnitude: float = 750
@export var initial_impulse_direction: Vector3 = Vector3(-1, 0, 0)

func _ready() -> void:
	apply_force(initial_impulse_direction * initial_impulse_magnitude)