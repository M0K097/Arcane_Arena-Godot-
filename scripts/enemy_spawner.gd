extends Node2D

var skeleton = preload("res://scenes/skeleton.tscn")
var slime = preload("res://scenes/slime.tscn")
var worm = preload("res://scenes/worm.tscn")

var enemies = [skeleton, slime, worm]
var player: CharacterBody2D
var activated = true

func _on_timer_timeout() -> void:
	if not activated:
		return
	var select = randi_range(0, enemies.size() - 1)
	select = 0
	var new_enemy = enemies[select].instantiate()
	if player != null:
		new_enemy.target = player
	get_tree().current_scene.add_child(new_enemy)
