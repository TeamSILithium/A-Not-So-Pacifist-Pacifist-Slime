extends Camera2D

var screenshake = false
var intensit1 = 0

func _ready():
	Global.camera = self

func _exit_tree():
	Global.camera = null

func _process(delta):
	zoom =  lerp(zoom, Vector2(1, 1), 0.3)
	
	if screenshake == true:
		global_position += Vector2(rand_range(-intensit1, intensit1), rand_range(-intensit1, intensit1)) * delta

func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.02, intensity * 0.02)
	intensit1 = intensity
	$Timer.wait_time = time
	$Timer.start()
	screenshake = true

func _on_Timer_timeout():
	screenshake = false
