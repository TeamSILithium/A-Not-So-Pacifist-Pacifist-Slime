extends KinematicBody2D

#define some variables
var speed = 130
var acc = 800
var motion = Vector2()
var dead = false
var deg_for_bullet : float
var vel : Vector2
var screensize : Vector2
var health = 3

signal ya_ded_son

onready var player = $Sprite
onready var anim = $Sprite/AnimationPlayer
onready var particle = $CPUParticles2D
onready var gun = $GunPoint/Gun
onready var gun_holder = $GunPoint
onready var sounds = $Sounds/AudioStreamPlayer

# physics stuff
func _physics_process(delta):
	if dead == false:
		gun_go_rotate_pls()
		var velocity = get_input()
		if velocity == Vector2.ZERO:
			apply_friction(acc * delta)
		else:
			apply_movement(velocity * acc * delta)
		motion = move_and_slide(motion)
		if health <= 0:
			die_lol()

# get input
func get_input():
	if not dead:
		# calculate movement
		var velocity = Vector2()
		velocity.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
		velocity.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
		if Input.is_action_pressed("Down") or Input.is_action_pressed("Up") or Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
			anim.play("Idle")
			particle.emitting = true
			if Input.is_action_pressed("Left"):
				player.flip_h = true
			if Input.is_action_pressed("Right"):
				player.flip_h = false
		else:
			anim.play("Idle")
			particle.emitting = false
			
		return velocity.normalized()

# add friction
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

# make the player move
func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(speed)
	
func gun_go_rotate_pls():
	var mouse_pos : Vector2 = get_global_mouse_position()
	deg_for_bullet = mouse_pos.angle_to_point(gun.global_position)
	gun_holder.look_at(mouse_pos)
	
	if global_position.x > mouse_pos.x:
		gun.scale.y = -1
	else:
		gun.scale.y = 1 

func die_lol():
	dead = true
	anim.play("Die")
	emit_signal("ya_ded_son")
	set_process(false)
	set_physics_process(false)
	set_process_internal(false)

func take_damage():
	health -= 1
	Global.health -= 1
	if Global.camera != null:
		Global.camera.screen_shake(15, 0.1)
	sounds.play()
	if health <= 0:
		die_lol()
	
func _ready():
	Global.player = self
	screensize = get_viewport_rect().size
	position = screensize/2

func _on_Restart_ITS_ALLIVE():
	addhealth()
	set_process(true)
	set_physics_process(true)
	set_process_internal(true)

func addhealth():
	health += 3
	Global.health += 3
