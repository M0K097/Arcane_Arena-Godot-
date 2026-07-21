extends CharacterBody2D
class_name Enemy

var player : CharacterBody2D
@export var movement_speed: float
@export var health: int

func _physics_process(_delta: float) -> void:
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * movement_speed
		move_and_slide()
	else:
		print(self.name , " has no player reference")
	
	if health <= 0:
		queue_free()

func do_damage(damage_value: int):
	health -= damage_value
	if health <= 0:
		queue_free()
