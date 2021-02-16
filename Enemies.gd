extends Node

var EnemiesForScore = 0
var enemy1 = preload("res://Assets/Objects/Enemy1/Enemy1.tscn")
var rand = RandomNumberGenerator.new()
var rand2 = RandomNumberGenerator.new()

onready var et = $EnemyTimer

func spawnEnemies():
	var screen_size = get_viewport().get_visible_rect().size
	var enemies = rand2.randi_range(1, 3)
	for _i in range(0, enemies):
		var enemy = enemy1.instance()
		rand.randomize()
		var x = rand.randf_range(48,screen_size.x - 48)
		rand.randomize()
		var y = rand.randf_range(48,screen_size.y - 48)
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)

func _on_EnemyTimer_timeout():
	spawnEnemies()
