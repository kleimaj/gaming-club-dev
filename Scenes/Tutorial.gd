extends Node2D

export var mushroomAmount = 3
var mushrooms_hit = 0

var steps_completed = 0

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
			get_tree().change_scene("res://Scenes/Game.tscn")
		elif event.pressed and event.scancode == KEY_1:
			get_tree().change_scene("res://Scenes/Cutscene/Intro.tscn")
		elif event.pressed and event.scancode == KEY_2:
			get_tree().change_scene("res://Scenes/Cutscene/MushroomHut.tscn")
		elif event.pressed and event.scancode == KEY_3:
			get_tree().change_scene("res://Scenes/Cutscene/Transition.tscn")
		elif event.pressed and event.scancode == KEY_4:
			get_tree().change_scene("res://Scenes/Game.tscn")
		elif event.pressed and event.scancode == KEY_5:
			get_tree().change_scene("res://Scenes/Cutscene/Ending.tscn")

var dialog_1 = [
	{
		'name': 'Prof. Flores',
		'content': 'Scroll the mouse wheel to zoom in an out of the level. Zoom all the way out.',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Great job, now zoom all the way back in!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Move the cannon with the A and D keys, move to the very end of the level and back',
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
	$Tank.enabled = false
	$CanvasLayer2/DialogueBox.connect("finished", self, "dialog_finished")
	$CanvasLayer2/DialogueBox.assign_dictionary(dialog_1)
	$CanvasLayer2/DialogueBox.fade_in()

func dialog_finished():
#	if dialog_count == 0:
#		$emcl/evilMist.set_process(true)
#		$Tank.enabled = true
#		dialog_count += 1
#	else:
		get_tree().change_scene("res://Scenes/Cutscene/Ending.tscn")

func checkGameOver(animType):
	pass
	
func incrementScore():
	mushrooms_hit += 1

func _on_ProgressBar_value_changed(value):
	$CanvasLayer2/ProgressBar/FinalProgress.visible = false
	if value <= 99:
		$CanvasLayer2/ProgressBar/FinalProgress.visible = false
	else:
		$CanvasLayer2/ProgressBar/FinalProgress.visible = true


func _on_Timer_timeout():
	#$Mist.hide()
	pass
	





func _on_RetryButton_pressed():
	get_tree().reload_current_scene()


func _on_Camera2D_reached_lower_limit():
	if steps_completed == 1:
		$CanvasLayer2/DialogueBox.load_dialog()
		steps_completed += 1
		$Tank.enabled = true


func _on_Camera2D_reached_upper_limit():
	if steps_completed == 0:
		$CanvasLayer2/DialogueBox.load_dialog()
		steps_completed += 1


func _on_RightArea_body_entered(body):
	print("RIGHT")

func _on_LeftArea_body_entered(body):
	print("LEFT")

