extends Node2D

@onready var player : CharacterBody2D = $Player
var enemies : Array
func _ready() -> void:
	randomize()
	enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		player.start_move.connect(enemy.on_start_move)
