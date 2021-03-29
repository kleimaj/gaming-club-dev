extends Control

onready var dialogueBox = $DialogueBox

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_S:
			# Skip to next scene
			pass
		elif event.pressed and event.scancode == KEY_G:
			get_tree().change_scene("res://Scenes/Game.tscn")

func fade_in_dialogue():
	dialogueBox.fade_in()
