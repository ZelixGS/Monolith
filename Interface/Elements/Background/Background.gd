extends TextureRect


@onready var gpu_particles_2d: GPUParticles2D = $Control/GPUParticles2D

func _on_visibility_changed() -> void:
	if gpu_particles_2d:
		if visible:
			gpu_particles_2d.emitting = true
		else:
			gpu_particles_2d.emitting = false
