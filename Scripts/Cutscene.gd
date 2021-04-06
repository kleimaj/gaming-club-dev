extends Control

onready var dialogueBox = $DialogueBox

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
			get_tree().change_scene("res://Scenes/Tutorial.tscn")
		elif event.pressed and event.scancode == KEY_5:
			get_tree().change_scene("res://Scenes/Game.tscn")
		elif event.pressed and event.scancode == KEY_6:
			get_tree().change_scene("res://Scenes/Cutscene/Ending.tscn")

func fade_in_dialogue():
	dialogueBox.fade_in()
