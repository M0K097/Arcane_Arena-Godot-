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
	chance_worm = total_chance * 0.6
	chance_skeleton = total_chance * 0.3
	chance_slime = 0.1
	gametime.start()

func _on_timer_timeout() -> void:
	if not activated:
		return
	var enemies_to_spawn = _choose_enemies()
	for marker in get_random_markers(bad_luck):
		_spawn_enemies(enemies_to_spawn, marker)

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
	if player.health == 1 and luck <= 30 or player.health <= 2 and luck <= 10 or luck <= 3:
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
	
func get_random_markers(how_many):
	var markers = get_children()
	var random_markers: Array[Marker2D] = []
	for turns in range(how_many):
		var rng = randi_range(0,markers.size()-1)
		var selected_marker = markers[rng]
		random_markers.push_front(selected_marker)
	return random_markers


func _spawn_enemies(list_of_enemies,marker: Marker2D):
	for enemy in list_of_enemies:
		if player != null:
			enemy.target = player
		get_tree().current_scene.add_child(enemy)
		enemy.global_position = marker.global_position
		enemy.hookup(_spawn_loot)
