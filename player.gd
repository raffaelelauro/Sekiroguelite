extends RigidBody3D

@export var move_speed: float = 10.0
@export var rotation_angle: float = PI / 8.0
@export var parry_radius: float = 2.0

@onready var parry_area: ParryArea = $ParryArea3D

var base_rotation: Vector3 = Vector3.ZERO
var target: Enemy = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup
	base_rotation = rotation;
	
	# Setup parry area
	if parry_area != null:
		parry_area.set_parry_radius(parry_radius)

func _process(delta: float) -> void:
	
	var target_rotation:Vector3 = Vector3.ZERO
		
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
		
	# Capture player actions
	if Input.is_action_just_pressed("Parry"):
		parry()
		
	# Update rotation
	rotation = rotation.move_toward(target_rotation, TAU * delta)
	
func parry() -> void:
	print('PARRY')
	if target != null :
		target.is_parried()


func _on_parry_area_3d_body_entered(body:Node3D) -> void:
	print('PARRIABLE DETECTED')
	if body != null :
		print('NEW TARGET')
		target = body
		
func _on_parry_area_3d_body_exited(body:Node3D) -> void:
	print('PARRIABLE LEFT')
	if target == body :
		print('NO MORE TARGET')
		target = null

func _on_body_entered(body: Node) -> void:
	print("HIT")