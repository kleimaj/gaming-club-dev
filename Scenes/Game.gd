extends Node2D

export var mushroomAmount = 3
var mushrooms_hit = 0

func checkGameOver():
	if mushrooms_hit == mushroomAmount:
		$evilMist.hide()

func incrementScore():
	mushrooms_hit += 1

func _on_ProgressBar_value_changed(value):
	$ProgressBar/FinalProgress.visible = false
	if value <= 99:
		$ProgressBar/FinalProgress.visible = false
	else:
		$ProgressBar/FinalProgress.visible = true
