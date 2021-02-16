extends HBoxContainer

var heart_full = preload("res://Assets/img/Heart.png")
var heart_empty = preload("res://Assets/img/HeartEmpty.png")

func _physics_process(_delta):
	print(Global.health)
	if Global.health == 2:
		$Heart3.texture = heart_empty
		$Heart2.texture = heart_full
		$Heart1.texture = heart_full
	if Global.health == 1:
		$Heart3.texture = heart_empty
		$Heart2.texture = heart_empty
		$Heart1.texture = heart_full
	if Global.health == 0:
		$Heart3.texture = heart_empty
		$Heart2.texture = heart_empty
		$Heart1.texture = heart_empty
	if Global.health == 3:
		$Heart3.texture = heart_full
		$Heart2.texture = heart_full
		$Heart1.texture = heart_full
