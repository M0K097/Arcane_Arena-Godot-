extends Node2D

@onready var player = $Player
@onready var HUD = $CanvasLayer/HUD


func _ready() -> void:
	$EnemySpawner.player = player
	player.HUD = $CanvasLayer/HUD
	HUD.update_health(player.health)
	
