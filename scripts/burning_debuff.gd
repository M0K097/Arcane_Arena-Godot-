extends Node2D

@export var burn_damage: int = 10
@export var total_turns = 5
var turns = 0
var target: CharacterBody2D

func _ready():
	target = get_parent()

func _on_timer_timeout() -> void:
	if turns > total_turns:
		queue_free()
	else:
		if target is Enemy:
			target.do_damage(burn_damage)
			turns += 1
