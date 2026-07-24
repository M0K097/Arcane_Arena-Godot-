extends Control

var last_value = 0

func update_health(value: int):
		$Healthbar.value = value
		$Healthbar/Label.text = str(value)
		if value < last_value:
			_animate_label_damage()
		last_value = value
		if value <= 0:
			queue_free()
	
func _animate_label_damage():
	$GPUParticles2D.emitting = true
	var label = $Healthbar/Label
	var tween = create_tween()
	tween.parallel().tween_property(label,"scale", Vector2(0.5,0.5), 0.1).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	var tween2 = create_tween()
	tween2.parallel().tween_property(label,"scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_LINEAR)
	
