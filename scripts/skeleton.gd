extends Enemy

@onready var animation = $AnimatedSprite2D

func _process(delta: float) -> void:
	animation.flip_sprite(velocity)
	animation.set_animation_based_on_health(health)
