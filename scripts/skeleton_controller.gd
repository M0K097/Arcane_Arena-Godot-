extends Node2D

@onready var animation = $AnimatedSprite2D

var body: CharacterBody2D
var last_health_value: int

func _process(_adelta: float) -> void:
	animation.flip_sprite(body.velocity)
	var health = body.health
	if health != last_health_value:
		_change_behavior(health)
		last_health_value = health

func connect_to(object: CharacterBody2D):
	body = object
	last_health_value = body.health
	
func _change_behavior(health):
	if health <= 50:
		animation.set_animation("nearly_done")
		animation.speed_scale = 2
		body.set_movement_speed(100)
	elif health <= 100:
		animation.speed_scale = 1.5
		animation.set_animation("headless")
		body.set_movement_speed(70)
	else:
		animation.speed_scale = 1
		animation.set_animation("default")
		body.set_movement_speed(50)
	
	
