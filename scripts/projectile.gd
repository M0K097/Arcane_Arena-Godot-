extends RigidBody2D
class_name projectile

var target: CharacterBody2D
var force: float = 100
var visible_notifier: VisibleOnScreenNotifier2D

func _ready() -> void:
	if target != null:
		var direction = global_position.direction_to(target.global_position)
		apply_central_impulse(direction * force)
		look_at(target.position)
	visible_notifier = VisibleOnScreenNotifier2D.new()
	add_child(visible_notifier)
	visible_notifier.screen_exited.connect(_remove)

func _remove():
	queue_free()
	
