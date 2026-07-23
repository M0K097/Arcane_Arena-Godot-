extends Enemy

var slime = preload("res://scenes/slime.tscn")

@onready var animation = $AnimatedSprite2D
@onready var shadow = $LightOccluder2D

func _ready() -> void:
	animation.play("default")

func _action_on_death():
	if scale.x > 0.5:
		for count in range(2):
			var spawn_position = self.global_position
			const OFFSET := Vector2(0,10)
			if count == 0:
				spawn_position += OFFSET
			else:
				spawn_position -= OFFSET
			_spawn_baby(spawn_position)

func _on_jump_area_body_entered(body: Node2D) -> void:
	if body is Player:
		animation.play("jump_attack")
		shadow.scale *= 0.5
		animation.position.y -= 10
		movement_speed = 120

func _on_jump_area_body_exited(body: Node2D) -> void:
	if body is Player:
		animation.play("default")
		animation.position.y += 10
		shadow.scale *= 2
		movement_speed = 50

func _spawn_baby(spawn_coordinates: Vector2):
		var baby_slime = slime.instantiate()
		baby_slime.scale *= 0.5
		baby_slime.health *= 0.5
		baby_slime.global_position = spawn_coordinates
		baby_slime.target = self.target
		get_tree().current_scene.add_child(baby_slime)
