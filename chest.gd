extends AnimatedSprite2D

var open: bool = false

var wand_of_fire = preload("res://scenes/fire_wand.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and not open:
		_animate_with_tween()
		open = true



func _animate_with_tween():
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0,-10), 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "scale", Vector2(1.2,1.2), 0.1).set_trans(Tween.TRANS_BOUNCE)
	play()
	_drop_item()
	tween.tween_property(self, "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "global_position", Vector2(0,0), 0.1).set_trans(Tween.TRANS_BOUNCE)

func _drop_item():
	$PointLight2D/GPUParticles2D.emitting = true
