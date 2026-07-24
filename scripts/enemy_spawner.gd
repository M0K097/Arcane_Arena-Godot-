extends Node2D

@onready var gametime = $GameTime

var skeleton = preload("res://scenes/skeleton.tscn")
var slime = preload("res://scenes/slime.tscn")
var worm = preload("res://scenes/worm.tscn")

var total_chance
var chance_skeleton
var chance_slime
var chance_worm

var bad_luck = 1

var chest = preload("res://scenes/chest.tscn")

var enemies = [skeleton, slime, worm]
var player: CharacterBody2D
var activated = true

func _ready() -> void:
	total_chance = gametime.wait_time
	chance_worm = total_chance * 0.5
	chance_skeleton = total_chance * 0.3
	chance_slime = total_chance * 0.1
	gametime.start()

func _on_timer_timeout() -> void:
	if not activated:
		return
	var enemies_to_spawn = _choose_enemies()
	_spawn_enemies(enemies_to_spawn)
	print("bad_luck = ",bad_luck)

func _spawn_chest(drop_chance, signal_position):
	var roll_the_dice = randi_range(0,100)
	if roll_the_dice <= drop_chance:
		var new_chest = chest.instantiate()
		new_chest.global_position = signal_position
		add_child(new_chest)

func _choose_enemies():
	var dice = randi_range(30 + (total_chance-gametime.time_left),30 +  (total_chance - gametime.time_left))
	print(dice)
	var to_spawn = []
	for bad in range(bad_luck):
		if dice >= chance_skeleton:
			to_spawn.push_back(skeleton.instantiate())
		if dice >= chance_slime:
			to_spawn.push_back(slime.instantiate())
		if dice >= chance_worm:
			to_spawn.push_back(worm.instantiate())
		if dice >= chance_worm:
			bad_luck += 1
	return to_spawn

func _spawn_enemies(list_of_enemies):
	for enemy in list_of_enemies:
		if player != null:
			enemy.target = player
		get_tree().current_scene.add_child(enemy)
		enemy.hookup(_spawn_chest)
