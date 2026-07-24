extends CharacterBody2D
class_name Enemy

var chest = preload("res://scenes/chest.tscn")

var target : CharacterBody2D
@export var movement_speed: float
@export var health: int

var minimal_movement_speed: float = 30

func _physics_process(_delta: float) -> void:
	if target != null:
		var direction = position.direction_to(target.position)
		velocity = direction * movement_speed
		move_and_slide()
	else:
		print(self.name , " has no player reference")


func _action_on_death():
	var tween = create_tween()
	var random_rotation = randi_range(10,40)
	tween.tween_property(self, "rotation", random_rotation , 0.3).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "scale", Vector2.ZERO , 0.2).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	queue_free()

func do_damage(damage_value: int):
	health -= damage_value
	if health <= 0:
		_action_on_death()

func set_movement_speed(value: int):
	if value >= 0 and value <= 1000:
		movement_speed = value
	else:
		print("value for speed: ", value, "out of range")
