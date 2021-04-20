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
		'content': 'Welcome to the tutorial! Scroll the mouse wheel to zoom in an out of the level. Zoom all the way out.',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Great job, now zoom all the way back in!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Move the cannon with the A and D keys, move to the very right with the D key',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Excellent! Now move back in place with the A key',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Try hitting the indicated blue mushroom! Hold and click your left mouse button to properly aim and fire the medicine!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Nice shot! Now try changing medicine types with your backpack! Click on the Yellow Medicine!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Nice work, check out your Book to refresh on what medicine is effective against blue spotted mushrooms!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Now you should know that Yellow Medicine is effective against Blue Spotted Mushrooms. Try hitting the last indicated mushroom!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Excellent work, you\'re all prepared to clear out the mist of the terrarium! Click to play the game!',
	},
]

var dialog_count = 0

onready var timer = $Timer

func _ready():
	$Tank.enabled = false
	$CanvasLayer2/DialogueBox.connect("finished", self, "dialog_finished")
	$CanvasLayer2/DialogueBox.assign_dictionary(dialog_1)
	$CanvasLayer2/DialogueBox.fade_in()

func dialog_finished():
	$HUD.hide()
	$HUD/CanvasLayer/BackpackButton.hide()
	$HUD/CanvasLayer/BookButton.hide()
	$AnimationPlayer.play("fade-out")
#	if dialog_count == 0:
#		$emcl/evilMist.set_process(true)
#		$Tank.enabled = true
#		dialog_count += 1
#	else:

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
	

func progress_tutorial():
	$CanvasLayer2/DialogueBox.load_dialog()
	steps_completed += 1

func _on_RetryButton_pressed():
	get_tree().reload_current_scene()


func _on_Camera2D_reached_lower_limit():
	if steps_completed == 1:
		progress_tutorial()
		$Tank.enabled = true


func _on_Camera2D_reached_upper_limit():
	if steps_completed == 0:
		progress_tutorial()
		$BackDrop/RightArrow.show()
		$AnimationPlayer.play("move-arrows")


func _on_RightArea_body_entered(body):
	if steps_completed == 2:
		progress_tutorial()
		$BackDrop/RightArrow.hide()
		$BackDrop/LeftArrow.show()
		$AnimationPlayer.play("move-arrows")

func _on_LeftArea_body_entered(body):
	if steps_completed == 3:
		progress_tutorial()
		$BackDrop/LeftArrow.hide()
		$BackDrop/MushroomArrow.show()
		$AnimationPlayer.play("move-arrows")

func _on_Blue_Mushroom_tutorial_hit():
	if steps_completed == 4:
		progress_tutorial()
		$BackDrop/MushroomArrow.hide()
		$CanvasLayer2/BackpackArrow.show()
		$HUD/CanvasLayer/BackpackGlow.show()
		$AnimationPlayer.play("move-arrows")


func _on_Tank_projectile_change():
	if steps_completed == 5:
		progress_tutorial()
		$CanvasLayer2/BackpackArrow.hide()
		$HUD/CanvasLayer/BackpackGlow.hide()
		$CanvasLayer2/BookArrow.show()
		$HUD/CanvasLayer/BookGlow.show()
		$AnimationPlayer.play("move-arrows")


func _on_TransitionBook_tutorial_item_found():
	if steps_completed == 6:
		progress_tutorial()
		$CanvasLayer2/BookArrow.hide()
		$HUD/CanvasLayer/BookGlow.hide()
		$BackDrop/MushroomArrow2.show()
		$AnimationPlayer.play("move-arrows")


func _on_Blue_Spotted_Mushroom_tutorial_hit():
	if steps_completed == 7:
		progress_tutorial()
		$BackDrop/MushroomArrow2.hide()
		$CanvasLayer2/DialogueBox.dialog_locked = false
		$Tank.enabled = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade-out":
		#get_tree().change_scene("res://Scenes/Game.tscn")
		SceneChanger.goto_scene("res://Scenes/Game.tscn")
