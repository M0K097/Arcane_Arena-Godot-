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
var healing_potion = preload("res://scenes/healing_potion.tscn")

var enemies = [skeleton, slime, worm]
var player: CharacterBody2D
var activated = true

func _ready() -> void:
	total_chance = gametime.wait_time
	chance_worm = total_chance * 0.5
	chance_skeleton = total_chance * 0.2
	chance_slime = total_chance * 0.1
	gametime.start()

func _on_timer_timeout() -> void:
	if not activated:
		return
	var enemies_to_spawn = _choose_enemies()
	_spawn_enemies(enemies_to_spawn)
	print("bad_luck = ",bad_luck)

func _spawn_loot(drop_chance, signal_position):
	_spawn_chest(drop_chance,signal_position)
	_spawm_potion(signal_position)


func _spawn_chest(chance,at_position):
	var roll_the_dice = randi_range(0,100)
	if roll_the_dice <= chance:
		var new_chest = chest.instantiate()
		new_chest.global_position = at_position
		call_deferred("add_child", new_chest)
		bad_luck += 0.5

func _spawm_potion(at_position):
	var luck = randi_range(0,100)
	if player.health == 1 and luck <= 40 or player.health <= 2 and luck <= 20 or luck <= 5:
		var healing = healing_potion.instantiate()
		healing.global_position = at_position
		call_deferred("add_child", healing)


func _choose_enemies():
	var dice = randi_range(30 ,30 +  (total_chance - gametime.time_left))
	print(dice)
	var to_spawn = []
	for bad in range(floor(bad_luck)):
		if dice >= chance_skeleton:
			to_spawn.push_back(skeleton.instantiate())
		if dice >= chance_slime:
			to_spawn.push_back(slime.instantiate())
		if dice >= chance_worm:
			to_spawn.push_back(worm.instantiate())
	return to_spawn

func _spawn_enemies(list_of_enemies):
	for enemy in list_of_enemies:
		if player != null:
			enemy.target = player
		get_tree().current_scene.add_child(enemy)
		enemy.hookup(_spawn_loot)
