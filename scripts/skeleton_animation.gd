extends AnimatedSprite2D

@onready var shadow = $LightOccluder2D

func _ready() -> void:
	set_animation_based_on_health(2)
	play()

func flip_sprite(velocity:Vector2):
	if velocity.x > 0:
		flip_h = true
		shadow.position.x -= 4
	else:
		flip_h = false
		shadow.position.x += 4
		
func set_animation_based_on_health(animation_index: int):
	match animation_index:
		0:
			play("nearly_done")
		1:
			play("headless")
		2:
			play("default")
