extends AnimatedSprite2D


func _ready() -> void:
	set_animation_based_on_health(2)
	play()

func flip_sprite(velocity:Vector2):
	if velocity.x > 0:
		flip_h = true
	else:
		flip_h = false
		
func set_animation_based_on_health(health: int):
	if health <= 50:
		play("nearly_done")
	elif health <= 100:
		play("headless")
	else:
		play("default")
