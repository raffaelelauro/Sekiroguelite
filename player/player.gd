extends RigidBody3D

class_name Player

var life: int;
@export var max_life:int = 3

@export var move_speed: float = 10.0
@export var rotation_angle: float = PI / 8.0
@export var parry_radius: float = 2.0
@export var back_position_speed: float = move_speed*2

@onready var parry_area: ParryArea = $ParryArea3D
@onready var disc: Node3D = $Disc

var base_rotation: Vector3 = Vector3.ZERO
var target: AbstractParriable = null
var initial_position: Vector3 = Vector3.ZERO
var to_initial_position: bool = false
var invincible: bool = false
var is_dead: bool = false

signal life_changed
signal dead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup
	base_rotation = rotation;
	initial_position = position
	life = max_life
	
	# Setup parry area
	if parry_area != null:
		parry_area.set_parry_radius(parry_radius)

func _process(delta: float) -> void:
	
	# Player not dead
	if not is_dead:
	
		# Is player dead ?
		if life <= 0 :
			is_dead = true
			dead.emit()
			disc.queue_free()
		else:
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
			
			if to_initial_position:
				disc.position = disc.position.move_toward(initial_position, delta*back_position_speed)
				if disc.position.is_equal_approx(initial_position):
					disc.position = initial_position
					to_initial_position = false
					invincible = false
	
func parry() -> void:
	print('PARRY')
	# Compute the new disc position
	var new_disc_position:Vector3 = disc.position
	if target != null:
		target.is_parried(self)
		new_disc_position = disc.position.move_toward(target.position, parry_radius)
		invincible = true
	else:
		new_disc_position = disc.position + Vector3(parry_radius, 0, 0)
	
	# Update disc position and rotation
	disc.position = new_disc_position
	to_initial_position = true

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
	if body is AbstractParriable :
		var body_parriable :AbstractParriable = body as AbstractParriable
		if !invincible:
			body_parriable.collision_hit();
			life -= 1
			life_changed.emit();
		else:
			print("INVINCIBLE")
		
func get_life() -> int :
	return life
