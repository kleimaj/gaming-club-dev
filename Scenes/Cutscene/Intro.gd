extends "res://Scripts/Cutscene.gd"

var dialog_dics = [
	{
		'name': null,
		'content': 'Hello there, welcome to the game! Press [color=#ff0000]Enter[/color] to continue!',
	},
	{
		'name': 'Player',
		'content': 'What\'s that?',
	},
]

var second_dialogue = [
	{
		'name': 'Cat',
		'content': 'Meow!',
	}
]
var first_finished = false

func _ready():
	$AnimationPlayer.play("BeginScene")

func _on_Button_pressed():
	$AnimationPlayer.play("FadeOutCanvas")

func dialog_finished():
	if not first_finished:
		$AnimationPlayer.play("zoom-in")
		first_finished = true
	else:
		$AnimationPlayer.play("EndScene")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOutCanvas":
		$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
		$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "zoom-in":
		$CanvasLayer/DialogueBox.assign_dictionary(second_dialogue)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		pass # change scene
