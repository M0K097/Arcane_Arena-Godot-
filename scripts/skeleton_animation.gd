extends AnimatedSprite2D

@export var loose_head_health: int
@export var only_torso_health: int

func _ready() -> void:
	play()

func flip_sprite(velocity:Vector2):
	if velocity.x > 0:
		flip_h = true
	else:
		flip_h = false
		
func set_animation_based_on_health(health: int):
	if health <= only_torso_health:
		play("nearly_done")
	elif health <= loose_head_health:
		play("headless")
	else:
		play("default")
