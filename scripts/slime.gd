extends Enemy

@onready var animation = $AnimatedSprite2D

func _ready() -> void:
	animation.play("default")
	
func _on_jump_area_body_entered(body: Node2D) -> void:
	if body is Player:
		animation.play("jump_attack")
		movement_speed = 120

func _on_jump_area_body_exited(body: Node2D) -> void:
	if body is Player:
		animation.play("default")
		movement_speed = 50


	
