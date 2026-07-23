extends Node2D

var target: CharacterBody2D
var original_speed: int
@export var slow_effect_strength = 30

func _ready():
	target = get_parent()
	$Timer.start()
	_apply_slow()

func _on_timer_timeout() -> void:
		target.change_speed(original_speed)
		queue_free()

func _apply_slow():
	if target is Enemy:
		original_speed = target.movement_speed
		target.change_speed(slow_effect_strength * -1)
