extends RigidBody2D
class_name Enemy

var player : CharacterBody2D
var movement_speed: float = 100

func _physics_process(_delta: float) -> void:
	var direction = position.direction_to(player.position)
	var applied_force = direction * movement_speed
	apply_central_force(applied_force)
