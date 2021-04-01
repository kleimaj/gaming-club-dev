extends Node2D

export var mushroomAmount = 3
var mushrooms_hit = 0
export var rain_seconds = 5

var rainScene = load("res://Scenes/Rain.tscn")
var last_med_color = null
var rs = null

var dialog_1 = [
	{
		'name': 'Prof. Flores',
		'content': 'It looks like the mist is encroaching on us… quickly! (use your scroll wheel to view the mist)',
	},
	{
		'name': 'Prof. Flores',
		'content': 'We must hit the mushrooms with medicine to drive the mist up and out of the terrarium.',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Move the cannon with the A and D keys!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Aim the cannon with your mouse. Click the mouse to launch the medicine',
	},
	{
		'name': 'Prof. Flores',
		'content': 'The longer you click, the farther the medicine will launch! Remember that!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'If you\'re not sure how to deal with each mushroom, check your guidebook again! Good luck!',
	},
]

var dialog_2 = [
	{
		'name': 'Prof. Flores',
		'content': 'Oh! You did it!! The medicine is mixing with the rainclouds and spreading across the terrarium! Let’s get out of here!'
	}
]

var dialog_count = 0

onready var timer = $Timer

func _ready():
	$evilMist.set_process(false)
	$CanvasLayer2/DialogueBox.connect("finished", self, "dialog_finished")
	$CanvasLayer2/DialogueBox.assign_dictionary(dialog_1)
	$CanvasLayer2/DialogueBox.fade_in()

func dialog_finished():
	if dialog_count == 0:
		$evilMist.set_process(true)
		dialog_count += 1
	else:
		get_tree().change_scene("res://Scenes/Cutscene/Ending.tscn")

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
	$CanvasLayer2/DialogueBox.assign_dictionary(dialog_2)
	$CanvasLayer2/DialogueBox.fade_in()
	
	


func _on_LostConditionArea_area_entered(area):
	$evilMist.set_process(false)
	$CanvasLayer2/YouLose.show()


func _on_RetryButton_pressed():
	get_tree().reload_current_scene()
