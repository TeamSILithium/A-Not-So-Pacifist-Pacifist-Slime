extends Area2D

func _physics_process(_delta):
	$Sprite/AnimationPlayer.play("Idle")

func _on_Area2D_body_entered(body):
	if "Enem" in body.name:
		$AudioStreamPlayer.play()
		Global.knockback += 0.1
		body.special_die()
		if Global.camera != null:
			Global.camera.screen_shake(15, 0.1)

	if "Play" in body.name:
		body.die_lol()
