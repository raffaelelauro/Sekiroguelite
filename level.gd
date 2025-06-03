extends Node3D

@onready var player_life: Label = $PlayerLife
@onready var game_over: Label = $GameOver
@onready var player: Player = $Player

func _ready() -> void:
	update_player_life_label()
	
func update_player_life_label() -> void :
	if player_life != null :
		if player != null :
			player_life.text = "Life : %d" % (player.get_life())
		else :
			player_life.text = "Life : Unknown :("
	else:
		print("Player life is empty")

		
func _on_player_life_changed() -> void:
	update_player_life_label()


func _on_player_dead() -> void:
	player_life.visible = false
	game_over.visible = true
