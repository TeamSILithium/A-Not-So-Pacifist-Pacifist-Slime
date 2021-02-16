extends TextureRect

func _physics_process(_delta):
	$AnimationPlayer.play("Idle")
