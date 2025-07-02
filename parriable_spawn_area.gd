extends Node3D

@export var wait_time: float = 5.0
@export var one_shot: bool = false
@export var object_type: Resource

@onready var timer = $Timer

func _ready() -> void:
	if timer != null :
		timer.wait_time = wait_time
		timer.one_shot = one_shot
		timer.start()

func spawn() -> void :
	if object_type != null:
		print("SPAWN")
		var object: AbstractParriable = object_type.instantiate()
		add_child(object)
	else :
		print("No object type parameter !")
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []
	
	if object_type == null :
		warnings.append("Parameter `object_type` is mandatory") 
	
	return warnings

func _on_timer_timeout() -> void:
	spawn()
