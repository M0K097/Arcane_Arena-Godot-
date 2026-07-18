extends AnimatedSprite2D

var direction: Vector2

func _process(delta: float) -> void:
	
	if direction == null:
		print("animation player has not frame")
		return
	elif direction == Vector2.ZERO:
		pause()
	else:
		_select_animation(direction)
		if !is_playing():
			play()

func _select_animation(direction):
	if direction.x > 0:
		animation = "player_side"
		flip_h = false
	elif direction.x < 0:
		animation = "player_side"
		flip_h = true
	elif direction.y < 0:
		animation = "player_back"
	elif direction.y > 0:
		animation = "player_front"
	
