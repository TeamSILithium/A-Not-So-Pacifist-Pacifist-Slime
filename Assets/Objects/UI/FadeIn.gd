extends ColorRect

signal fade_finished

func fade_in():
	$AnimationPlayer.play("Fade")

func _on_AnimationPlayer_animation_finished(Fade):
	emit_signal("fade_finished")
