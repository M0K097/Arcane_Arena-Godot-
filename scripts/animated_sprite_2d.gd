extends AnimatedSprite2D

func _select_animation(velocity: Vector2):
		if velocity.x > 0 and velocity.x > velocity.y:
			play("player_side")
			flip_h = false
		elif velocity.x < 0 and velocity.x < velocity.y:
			play("player_side")
			flip_h = true
		elif velocity.y > 0 and velocity.y > velocity.x:
			play("player_front")
		elif velocity.y < 0 and velocity.y < velocity.x:
			play("player_back")
		elif velocity == Vector2.ZERO:
			pause()
