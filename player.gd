extends RigidBody3D

@export var move_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	# Capture player movement
	if Input.is_action_pressed("Front"):
		position.x += move_speed*delta
	if Input.is_action_pressed("Back"):
		position.x -= move_speed*delta
	if Input.is_action_pressed("Left"):
		position.z -= move_speed*delta
	if Input.is_action_pressed("Right"):
		position.z += move_speed*delta
	
