extends CharacterBody2D
class_name Enemy

var chest = preload("res://scenes/chest.tscn")
signal on_enemy_died(drop_chance:int, position:Vector2)

var target : CharacterBody2D
var chest_chance_in_percent: int = 100
@export var movement_speed: float
@export var health: int
@export var drop_chance: int
@export var damage = 1

var minimal_movement_speed: float = 10

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
	on_enemy_died.emit(drop_chance, self.global_position)
	tween.tween_property(self, "rotation", random_rotation , 0.3).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "scale", Vector2.ZERO , 0.2).set_trans(Tween.TRANS_QUAD)
	await tween.finished

func do_damage(damage_value: int):
	health -= damage_value
	if health <= 0:
		await _action_on_death()
		_second_action_on_death()
		queue_free()

func hookup(chest_method):
	on_enemy_died.connect(chest_method)

func set_movement_speed(value: int):
	if value >= 0 and value <= 1000:
		movement_speed = value
	else:
		print("value for speed: ", value, "out of range")

func _second_action_on_death():
	pass
