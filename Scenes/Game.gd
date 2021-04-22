extends Node2D

export var mushroomAmount = 8.0
var mushrooms_hit = 0
export var rain_seconds = 5

var rainScene = load("res://Scenes/Rain.tscn")
var last_med_color = null
var rs = null

# skippable scenes
func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_S:
			# Skip to next scene
			pass
		elif event.pressed and event.scancode == KEY_G:
			#get_tree().change_scene("res://Scenes/Game.tscn")
			SceneChanger.goto_scene("res://Scenes/Game.tscn")
		elif event.pressed and event.scancode == KEY_1:
			#get_tree().change_scene("res://Scenes/Cutscene/Intro.tscn")
			SceneChanger.goto_scene("res://Scenes/Cutscene/Intro.tscn")
		elif event.pressed and event.scancode == KEY_2:
			#get_tree().change_scene("res://Scenes/Cutscene/MushroomHut.tscn")
			SceneChanger.goto_scene("res://Scenes/Cutscene/MushroomHut.tscn")
		elif event.pressed and event.scancode == KEY_3:
			#get_tree().change_scene("res://Scenes/Cutscene/Transition.tscn")
			SceneChanger.goto_scene("res://Scenes/Cutscene/Transition.tscn")
		elif event.pressed and event.scancode == KEY_4:
			#get_tree().change_scene("res://Scenes/Tutorial.tscn")
			SceneChanger.goto_scene("res://Scenes/Tutorial.tscn")
		elif event.pressed and event.scancode == KEY_5:
			#get_tree().change_scene("res://Scenes/Game.tscn")
			SceneChanger.goto_scene("res://Scenes/Game.tscn")
		elif event.pressed and event.scancode == KEY_6:
			#get_tree().change_scene("res://Scenes/Cutscene/Ending.tscn")
			SceneChanger.goto_scene("res://Scenes/Cutscene/Ending.tscn")

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
#	$emcl/evilMist.set_process(false)
#	$Tank.enabled = false
	$CanvasLayer2/DialogueBox.connect("finished", self, "dialog_finished")
#	$CanvasLayer2/DialogueBox.assign_dictionary(dialog_1)
#	$CanvasLayer2/DialogueBox.fade_in()

func dialog_finished():
#	if dialog_count == 0:
#		$emcl/evilMist.set_process(true)
#		$Tank.enabled = true
#		dialog_count += 1
#	else:
		#get_tree().change_scene("res://Scenes/Cutscene/Ending.tscn")
		$AnimationPlayer.play("FadeAway")
		if yield($AnimationPlayer, "animation_finished"):
			SceneChanger.goto_scene("res://Scenes/Cutscene/Ending.tscn")

func checkGameOver(animType):
	if mushrooms_hit == mushroomAmount:
		rs = rainScene.instance()
		add_child(rs)
		rs.start_rain(animType)
		var animation = $CameraAnimationPlayer.get_animation("zoom_out")
		$Tank.enabled = false
		$HUD/CanvasLayer/BackpackButton.hide()
		$HUD/CanvasLayer/BookButton.hide()
		animation.track_insert_key(0, 0.0, $Camera2D.zoom)
		$Camera2D.limit_left -= ((3.0 - $Camera2D.zoom.x) * 500)
		$Camera2D.limit_right += ((3.0 - $Camera2D.zoom.y) * 500)
		$CameraAnimationPlayer.play("zoom_out")
		$Camera2D.smoothing_enabled = true
		$Camera2D.smoothing_speed = 5
		rs.get_node("RainSound").play()
		$CanvasLayer3/MistCanvas/BackgroundMist.emitting = false
		timer.set_wait_time(rain_seconds)
		timer.start();
	else:
		$CameraAnimationPlayer.play("cat_smile")
	
func incrementScore(increaseByVal):
	mushrooms_hit += increaseByVal


func _on_ProgressBar_value_changed(value):
	$CanvasLayer2/ProgressBar/FinalProgress.visible = false
	if value <= 99:
		$CanvasLayer2/ProgressBar/FinalProgress.visible = false
	else:
		$CanvasLayer2/ProgressBar/FinalProgress.visible = true


func _on_Timer_timeout():
	#$Mist.hide()
	$CanvasLayer2/DialogueBox.assign_dictionary(dialog_2)
	$CanvasLayer2/DialogueBox.fade_in()
	
	


func _on_LostConditionArea_area_entered(area):
	#$emcl/evilMist.set_process(false)
	#$CanvasLayer2/YouLose.show()
	pass


func _on_RetryButton_pressed():
	get_node("HUD").pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = false
	get_tree().reload_current_scene()
