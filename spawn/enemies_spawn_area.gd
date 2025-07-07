extends ParriableSpawnArea

class_name EnemiesSpawnArea

@export var target:Node3D

func create_spawnable() -> AbstractParriable:
	print("Spawning enemy with target " + target.name)
	var enemy: Enemy = super.create_spawnable() as Enemy
	enemy.target = target
	return enemy
