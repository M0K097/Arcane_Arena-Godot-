extends projectile

@export var damage = 50
var burn_effect = preload("res://resources/burning_debuff.tscn")

func _on_body_entered(body: Node) -> void:
	print(body)
	if body is Enemy:
		body.do_damage(damage)
		body.add_child(burn_effect.instantiate())
		queue_free()
