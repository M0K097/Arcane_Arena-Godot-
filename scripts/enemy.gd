extends CharacterBody2D
class_name Enemy

var target : CharacterBody2D
@export var movement_speed: float
@export var health: int

func _physics_process(_delta: float) -> void:
	if target != null:
		var direction = position.direction_to(target.position)
		velocity = direction * movement_speed
		move_and_slide()
	else:
		print(self.name , " has no player reference")
	
	if health <= 0:
		_action_on_death()
		queue_free()

func _action_on_death():
	pass

func do_damage(damage_value: int):
	health -= damage_value
	if health <= 0:
		queue_free()

func set_movement_speed(value: int):
	if value >= 0 and value <= 1000:
		movement_speed = value
	else:
		print("value for speed: ", value, "out of range")
