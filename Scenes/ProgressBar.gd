extends TextureProgress

var totalEnemy = 8


func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	value += 25

func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	value -= 25

func incrementValue():
	var endValue = value + ((100-value)/totalEnemy)
	animateHealth(value, endValue)
	#value = endValue
	totalEnemy -= 1
	if totalEnemy == 0:
		animateHealth(value, 100)

func decrementValue(amount=6):
	checkHealth()
	var endValue = value - amount
	animateHealth(value, endValue)
	#value = endValue
	
func checkHealth():
	if value <= 25:
		texture_progress = load("res://Assets/GFX/UI/meterInsideMiddleRed.png")
		$FinalProgress2.texture = load("res://Assets/GFX/UI/meterInsideCapRed.png")
		$RedAlertAP.play("RedBlink")
	else:
		texture_progress = load("res://Assets/GFX/UI/meterInsideMiddle.png")
		$FinalProgress2.texture  = load("res://Assets/GFX/UI/meterInsideCap.png")
		$RedAlertAP.stop()
		
	if value <= 15:
		get_parent().get_parent().get_node("CanvasLayer2/YouLose").show()

func animateHealth(startValue, endValue):
	var animation = $HealthMoveAP.get_animation("Move")
	animation.track_insert_key(0, 0.0, startValue)
	animation.track_insert_key(0, 1.0, endValue)
	$HealthMoveAP.play("Move")
