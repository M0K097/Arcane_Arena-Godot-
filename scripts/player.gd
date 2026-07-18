extends CharacterBody2D

@export var speed_multiplier: float = 1

const SPEED = 300.0
const SMOOTHING = 3

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("go_left","go_right","go_up","go_down")
	var applied_speed = SPEED * speed_multiplier
	if direction:
		velocity = velocity.move_toward( direction * applied_speed , applied_speed / SMOOTHING)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, applied_speed / SMOOTHING)
			
	move_and_slide()
