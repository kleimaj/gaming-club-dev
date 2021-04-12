extends TextureProgress

var totalEnemy = 8
var loosePointsCount = 6
var redLimit = 25
var looseLimit = 15
var maxPoints = 100
onready var startHP = value
onready var starthasPos =   $HealthAnim.position
onready var currenthasPos = $HealthAnim.position
onready var greenProgress = load("res://Assets/GFX/UI/meterInsideMiddle.png")
onready var greenCap = load("res://Assets/GFX/UI/meterInsideCap.png")
onready var redProgress = load("res://Assets/GFX/UI/meterInsideMiddleRed.png")
onready var redCap = load("res://Assets/GFX/UI/meterInsideCapRed.png")
onready var looseScene = get_parent().get_parent().get_node("CanvasLayer2/YouLose")

func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	value += 25

func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	value -= 25

func incrementValue():
	var newVal = ((maxPoints-value)/totalEnemy)
	var endValue = value + newVal
	var newPos = Vector2(newHealthMoveAP(endValue),currenthasPos.y)
	totalEnemy -= 1
	if totalEnemy <= 0:
		$HealthAnim.visible = false
		endValue = maxPoints
	animateHealth(value, endValue, newPos)


func decrementValue(amount=loosePointsCount):
	if totalEnemy > 0 :
		var endValue = value - amount
		var newPos = Vector2(newHealthMoveAP(endValue),currenthasPos.y)
		animateHealth(value, endValue, newPos)
			

func animateHealth(startValue, endValue, animPos):
	var animation = $HealthMoveAP.get_animation("Move")
	animation.track_insert_key(0, 0.0, startValue)
	animation.track_insert_key(0, 1.0, endValue)
	animation.track_insert_key(1, 0.0, currenthasPos)
	animation.track_insert_key(1, 1.0, animPos)
	$HealthMoveAP.play("Move")
	currenthasPos = animPos
	if yield($HealthMoveAP, "animation_finished"):
		if value <= looseLimit:
			$RedAlertAP.stop()
			visible = true
			get_parent().get_parent().get_node("HUD").pause_mode = PAUSE_MODE_INHERIT
			get_tree().paused = true
			looseScene.show()
		else:
			checkHealth()
		return
	
	
func newHealthMoveAP(eVal):
	return (eVal *  starthasPos.x)/ startHP
	
func checkHealth():
	$HealthAnim.frame = 0
	visible = true
	if value <= redLimit:
		$HealthAnim.play("Red")
		texture_progress = redProgress
		$FinalProgress2.texture = redCap
		$RedAlertAP.play("RedBlink")
	else:
		$HealthAnim.play("Green")
		texture_progress = greenProgress
		$FinalProgress2.texture  = greenCap
		$RedAlertAP.stop()
