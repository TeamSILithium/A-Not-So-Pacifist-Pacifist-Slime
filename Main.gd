extends Node2D

var ded = false

onready var bullet_folder = $Bullet
onready var gun = $Player/GunPoint/Gun/Sounds/AudioStreamPlayer

func _input(event: InputEvent):
	if ded == false:
		if event.is_action_pressed("Shoot"):
			gun.playing = true
			var bullet = preload("res://Assets/Objects/Bullet/Bullet.tscn").instance()
			bullet.rotation = $Player.deg_for_bullet
			bullet.global_position = $Player/GunPoint/Gun/Muzzle.global_position
			add_child(bullet)

func _on_Player_ya_ded_son():
	ded = true
