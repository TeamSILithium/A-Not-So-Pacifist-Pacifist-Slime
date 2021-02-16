extends Control
var ded = false

func _on_Button_pressed():
	if ded == false:
		$FadeIn.show()
		$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	if ded == false:
		$FadeIn.hide()
		hide()

func _on_Player_ya_ded_son():
	show()
	ded = true
