extends AnimatedSprite2D

var open: bool = false
var pickup = preload("res://scenes/pickup.tscn")

func _ready() -> void:
	var tween = create_tween()
	scale = Vector2.ZERO
	tween.parallel().tween_property(self, "position", position + Vector2(0,20), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(self, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BOUNCE)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and not open:
		_animate_with_tween()
		open = true

func _animate_with_tween():
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0,-20), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.5).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	play()
	_drop_item()
	var tween2 = create_tween()
	tween2.parallel().tween_property(self, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween2.parallel().tween_property(self, "position", position + Vector2(0,20), 0.3).set_trans(Tween.TRANS_BOUNCE)
	await tween2.finished
	var tween3 = create_tween()
	tween3.parallel().tween_property(self, "rotation", randi_range(10,40), 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween3.parallel().tween_property(self, "scale", Vector2.ZERO, 0.5).set_trans(Tween.TRANS_BOUNCE)
	await tween3.finished
	queue_free()
	
func _drop_item():
	$PointLight2D/GPUParticles2D.emitting = true
	var dropped_item = pickup.instantiate()
	dropped_item.global_position = global_position
	get_tree().current_scene.add_child(dropped_item)
