extends Node2D

var target: CharacterBody2D
var original_speed: int
var slowed:bool = false
@export var slow_effect_strength = 30

func _ready():
	target = get_parent()
	$Timer.start()
	_apply_slow()

func _on_timer_timeout() -> void:
		target.set_movement_speed(original_speed)
		queue_free()

func _apply_slow():
	if target is Enemy:
		if not slowed:
			original_speed = target.movement_speed
			slowed = true
		var new_speed = target.movement_speed - slow_effect_strength
		target.set_movement_speed(new_speed)
