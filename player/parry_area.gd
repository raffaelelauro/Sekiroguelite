extends Area3D

class_name ParryArea

@export var initial_parry_radius: float = 2.0
@onready var collision_sphere: CollisionShape3D = $CollisionShape3D
var sphere: SphereShape3D

func _ready() -> void:
	# Init Sphere
	sphere = SphereShape3D.new()
	sphere.set_radius(initial_parry_radius)
	
	# Init collision sphere
	if collision_sphere != null:
		collision_sphere.set_shape(sphere)
	else:
		print("Parry Area has no collision sphere instantiated")
		
func set_parry_radius(radius: float) ->void :
	sphere.set_radius(radius)