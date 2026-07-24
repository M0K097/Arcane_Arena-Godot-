extends CharacterBody2D
class_name Player

@onready var animator = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var hitbox = $HitBox


const max_health = 10
const SPEED = 100
const SMOOTHING = 2

var last_direction
var health = 3
var HUD
var on_damage_cooldown = false


func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("go_left" ,"go_right" ,"go_up" ,"go_down")
	if direction != last_direction:
		var applied_movement = direction * SPEED
		velocity = applied_movement
		animator._select_animation(velocity)
		last_direction = direction
	
	if not on_damage_cooldown:
		_check_for_hit()
	move_and_slide()

func get_damage(body_that_hit: CharacterBody2D):
	if body_that_hit is Enemy:
		health -= body_that_hit.damage
		HUD.update_health(health)
		camera.apply_shake(10)
		on_damage_cooldown = true
		$HitBox/DamageCooldown.start()
		if health <= 0:
			_death()

func _check_for_hit():
	var hit_by = hitbox.get_overlapping_bodies()
	if hit_by.size() == 0:
		return
	for body in hit_by:
		if body is Enemy:
			get_damage(body)


func _death():
		var tween = create_tween()
		tween.parallel().tween_property(self, "rotation", 90, 2).set_trans(Tween.TRANS_BOUNCE)
		tween.parallel().tween_property(self, "scale", Vector2.ZERO , 1).set_trans(Tween.TRANS_BOUNCE)
		await tween.finished
		queue_free()
		print("GAME OVER")


func _on_damage_cooldown_timeout() -> void:
	on_damage_cooldown = false
