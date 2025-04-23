extends RigidBody3D

@export var move_speed = 10
@export var rotation_angle = PI / 8.0

var base_rotation = Vector3.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_rotation = rotation;
	pass # Replace with function body.

func _process(delta: float) -> void:
	
	var target_rotation = Vector3.ZERO
		
	# Capture player movement
	if Input.is_action_pressed("Front"):
		position.x += move_speed*delta
		target_rotation.z = base_rotation.z-rotation_angle
	if Input.is_action_pressed("Back"):
		position.x -= move_speed*delta
		target_rotation.z = base_rotation.z+rotation_angle
	if Input.is_action_pressed("Left"):
		position.z -= move_speed*delta
		target_rotation.x = base_rotation.x-rotation_angle
	if Input.is_action_pressed("Right"):
		position.z += move_speed*delta
		target_rotation.x = base_rotation.x+rotation_angle
		
	# Update rotation
	rotation = rotation.move_toward(target_rotation, TAU * delta)
