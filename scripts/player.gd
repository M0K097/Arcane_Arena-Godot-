extends CharacterBody2D
class_name Player

@onready var animator = $AnimatedSprite2D

const SPEED = 150
const SMOOTHING = 2

var last_direction

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("go_left" ,"go_right" ,"go_up" ,"go_down")
	if direction != last_direction:
		var applied_movement = direction * SPEED
		velocity = applied_movement
		animator._select_animation(velocity)
		last_direction = direction

	move_and_slide()
