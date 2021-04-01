extends Node2D

export var mushroomAmount = 3
var mushrooms_hit = 0
export var rain_seconds = 5

var rainScene = load("res://Scenes/Rain.tscn")
var last_med_color = null
var rs = null

onready var timer = $Timer

func checkGameOver(animType):
	if mushrooms_hit == mushroomAmount:
		$evilMist.hide()
		rs = rainScene.instance()
		add_child(rs)
		rs.start_rain(animType)
		var animation = $CameraAnimationPlayer.get_animation("zoom_out")
		animation.track_insert_key(0, 0.0, $Camera2D.zoom)
		$Camera2D.limit_left -= ((3.0 - $Camera2D.zoom.x) * 500)
		$Camera2D.limit_right += ((3.0 - $Camera2D.zoom.y) * 500)
		$CameraAnimationPlayer.play("zoom_out")
		$Camera2D.smoothing_enabled = true
		$Camera2D.smoothing_speed = 5
		timer.set_wait_time(rain_seconds)
		timer.start();
	
func incrementScore():
	mushrooms_hit += 1

func _on_ProgressBar_value_changed(value):
	$CanvasLayer2/ProgressBar/FinalProgress.visible = false
	if value <= 99:
		$CanvasLayer2/ProgressBar/FinalProgress.visible = false
	else:
		$CanvasLayer2/ProgressBar/FinalProgress.visible = true


func _on_Timer_timeout():
	$Mist.hide()
	
	
