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
	{
		'name': 'Cat',
		'content': 'Meow!',
	}
]

func _on_Button_pressed():
	$AnimationPlayer.play("FadeOutCanvas")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "FadeOutCanvas":
		$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
		$CanvasLayer/DialogueBox.fade_in()
