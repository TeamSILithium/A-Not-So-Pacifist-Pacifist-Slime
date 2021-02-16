extends CPUParticles2D

var fade = false
var alpha = 1

func start_timer():
	$Timer.start()

func start_fadetimer():
	$FadeTimer.start()

func _on_FadeTimer_timeout():
	fade = true

func _process(_delta):
	if fade:
		alpha = lerp(alpha, 0, 0.1)
		modulate.a = alpha
		if alpha < 0.005:
			queue_free()

func _on_Timer_timeout():
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
