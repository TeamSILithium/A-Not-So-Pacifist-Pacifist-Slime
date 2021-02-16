extends TextureButton

signal ITS_ALLIVE

func _on_Restart_pressed():
	emit_signal("ITS_ALLIVE")
	get_tree().reload_current_scene()
	Global.score = 0
	Global.knockback = 20
