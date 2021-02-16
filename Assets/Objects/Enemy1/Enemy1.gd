extends KinematicBody2D

var dead = false
var state = 0
var speed = 50
var player = null
var health = 4
var stun = false
var knockback
var spawn = false

onready var animation = $Sprite/AnimationPlayer
onready var particle = $CPUParticles2D
onready var col = $CollisionShape2D
onready var sprite = $Sprite
onready var stuntimer = $StunTimer
onready var audio = $Sounds/AudioStreamPlayer
onready var audiodeath = $Sounds/AudioStreamPlayer2
onready var deathtimer = $Death

var blood = preload("res://Assets/Objects/Enemy1/BloodyStream.tscn")
var player1 = preload("res://Assets/Objects/Player/Player.tscn")

var velocity = Vector2()

func _physics_process(_delta):
	if dead == false:
		movement()
		velocity = move_and_slide(velocity)
		knockback = Global.knockback
	if Global.secret_score >= 50:
		Global.secret_score = 0

func movement():
	if dead == false and not stun and not spawn:
		if player and dead == false and Global.player.dead == false:
			velocity = (player.position - position).normalized() * speed
			particle.emitting = true
	elif stun and not spawn:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
	return velocity.normalized()

func take_damage():
	if stun == false:
		stun = true
		audio.playing = true
		health -= 1
		velocity = -velocity * knockback
		stuntimer.start()
	if health <= 0:
		Global.score += 1
		if Global.camera != null:
			Global.camera.screen_shake(15, 0.1)
		var blood_instance = blood.instance()
		blood_instance.start_fadetimer()
		blood_instance.start_timer()
		get_tree().current_scene.add_child(blood_instance)
		blood_instance.global_position = global_position
		sprite.visible = false
		audiodeath.playing = true
		deathtimer.start()

# die lol
func die():
	dead = true
	Global.score += 1
	Global.secret_score += 1
	queue_free()

# die in lava lol
func special_die():
	var blood_instance = blood.instance()
	blood_instance.start_fadetimer()
	blood_instance.start_timer()
	get_tree().current_scene.add_child(blood_instance)
	blood_instance.global_position = global_position
	Global.score += 3
	Global.secret_score += 3
	dead = true
	queue_free()

# detect if player has entered
func _on_Area2D_Player_entered(body):
	if "Player" in body.name:
		player = body

#let the player take damage
func _on_Damage_body_entered(body):
	if "Player" in body.name:
		body.take_damage()

# reverse stunning
func _on_StunTimer_timeout():
	stun = false

func _on_Death_timeout():
	die()
