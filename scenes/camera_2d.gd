extends Camera2D

var shake_strength := 0.0
var shake_fade := 20.0

func apply_shake(strength: float):
	shake_strength = strength

func _process(delta):
	if shake_strength > 0:
		shake_strength = move_toward(shake_strength, 0.0, shake_fade * delta)

		offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = Vector2.ZERO
