extends Node2D

@onready var player = $Player


func _ready() -> void:
	$EnemySpawner.player = player
	player.HUD = $CanvasLayer/HUD
