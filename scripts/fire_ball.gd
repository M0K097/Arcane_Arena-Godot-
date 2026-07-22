extends projectile

@export var damage = 50
var burn_effect = preload("res://scenes/burning_debuff.tscn")

func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.do_damage(damage)
		body.add_child(burn_effect.instantiate())
		_activate_particle_impact()
		queue_free()

func _activate_particle_impact():
	var particles = $ GPUParticles2D
	remove_child(particles)
	get_tree().current_scene.add_child(particles)
	var timer = Timer.new()
	timer.wait_time = 0.5
	_change_particle_effect(particles)
	particles.add_child(timer)
	timer.timeout.connect(particles._remove_particles)
	timer.start()
	
func _change_particle_effect(particles):
	particles.global_position = global_position
	particles.speed_scale = 10
	particles.lifetime = 3
	particles.amount = 50
	particles.trail_enabled = true
	particles.process_material.set_spread(100.0)
	particles.process_material.direction = Vector3(linear_velocity.x, linear_velocity.y, 0)
	particles.one_shot = true
	
	
	
