extends Node2D

@onready var animation = $AnimatedSprite2D

var body: CharacterBody2D
var last_health_value: int

func _process(delta: float) -> void:
	animation.flip_sprite(body.velocity)
	var health = body.health
	if health != last_health_value:
		animation.set_animation_based_on_health(health)
		last_health_value = health

func connect_to(object: CharacterBody2D):
	body = object
	last_health_value = body.health
