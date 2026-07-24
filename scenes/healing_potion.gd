extends AnimatedSprite2D

@onready var shine = $PointLight2D

func _ready():
	var tween = create_tween()
	tween.parallel().tween_property(self, "position", position + Vector2(0,20), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(self, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BOUNCE)
	$GPUParticles2D.emitting = true
	
func _process(_delta: float) -> void:
	var tween = create_tween()
	var flicker = randf_range(0.5,1.5)
	tween.tween_property($PointLight2D, "scale", Vector2(flicker, flicker),0.1).set_trans(Tween.TRANS_LINEAR)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.heal()
		var tween = create_tween()
		tween.parallel().tween_property(self, "scale", Vector2(2,2), 0.2).set_trans(Tween.TRANS_BOUNCE)
		await tween.finished
		queue_free()
	
