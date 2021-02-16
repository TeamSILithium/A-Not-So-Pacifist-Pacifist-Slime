extends Area2D

export var speed = 300
var vel : Vector2

onready var deathpar = $CPUParticles2D2

func _ready():
	vel = Vector2(speed, 0).rotated(Global.player.deg_for_bullet)

func _process(delta: float):
	position += vel * delta

func _on_bullet_body_entered(body):
	queue_free()
	if "Enem" in body.name:
		body.take_damage()
