extends Node

var score = 0
var player
var secret_score = 0
var health = 3
var camera
var dead = false
var knockback = 20

func _physics_process(delta):
	if secret_score >= 50:
		knockback += 2
		secret_score = 0
