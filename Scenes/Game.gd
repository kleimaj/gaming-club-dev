extends Node2D



func _on_ProgressBar_value_changed(value):
	$ProgressBar/FinalProgress.visible = false
	if value <= 99:
		$ProgressBar/FinalProgress.visible = false
	else:
		$ProgressBar/FinalProgress.visible = true
