extends Node3D

class_name Wave

enum WaveType {
	WAVE_1,
	WAVE_2_1,
	WAVE_2_2,
	WAVE_2_3,
	WAVE_3_1,
	WAVE_3_2,
	WAVE_3_3,
	WAVE_4_1,
	WAVE_4_2,
	WAVE_4_3,
	WAVE_5_1,
	WAVE_5_2,
	WAVE_5_3,
	WAVE_5_4,
	WAVE_5_5
} 

@export var waves: Array[WaveType]
@export var target: Player

@onready var timer = $Timer
@onready var enemies_spawn_area_0: EnemiesSpawnArea = $EnemiesSpawnArea0
@onready var enemies_spawn_area_R1: EnemiesSpawnArea = $EnemiesSpawnAreaR1
@onready var enemies_spawn_area_R2: EnemiesSpawnArea = $EnemiesSpawnAreaR2
@onready var enemies_spawn_area_L1: EnemiesSpawnArea = $EnemiesSpawnAreaL1
@onready var enemies_spawn_area_L2: EnemiesSpawnArea = $EnemiesSpawnAreaL2

func _ready() -> void:
	enemies_spawn_area_0.target = self.target
	enemies_spawn_area_R1.target = self.target
	enemies_spawn_area_R2.target = self.target
	enemies_spawn_area_L1.target = self.target
	enemies_spawn_area_L2.target = self.target
	
	timer.process_callback = self.execute_next_wave
	timer.start()
	
func execute_next_wave() -> void :
	# Pop out first wave
	# Analyse its value and execute proper processing
	# Launch timer for next wave
	pass
