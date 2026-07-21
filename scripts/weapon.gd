extends Node2D
class_name weapon

@onready var area_of_attack = $AttackArea

@export var weapon_data: WeaponResource

var attack_timer: Timer

func _ready():
	_initiate_attack_timer()

func _attack():
	var target = area_of_attack.get_closest_enemy()
	if target == null:
		return
		
	print("attacking with ", weapon_data.name, "Target:", target.name)
	_instantiate_projectile(target)

func _initiate_attack_timer():
	attack_timer = Timer.new()
	attack_timer.wait_time = weapon_data.cooldown
	add_child(attack_timer)
	attack_timer.timeout.connect(_attack)
	attack_timer.start()

func _instantiate_projectile(target: CharacterBody2D):
	var shot = weapon_data.projectile_scene.instantiate()
	shot.global_position = global_position
	shot.target = target
	get_tree().current_scene.add_child(shot)
