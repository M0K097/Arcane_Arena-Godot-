extends GPUParticles2D

func _remove_particles():
	queue_free()
