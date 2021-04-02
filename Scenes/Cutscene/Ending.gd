extends "res://Scripts/Cutscene.gd"

var dialog_dics = [
	{
		'name': 'Prof. Flores',
		'content': 'Thanks again for all your help! Good luck at your meeting, you’re welcome to come by and visit anytime!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'I have a feeling I may need your help with the rest of my terrariums in the future...',
	},
]

func _ready():
	$AnimationPlayer.play("BeginScene")
	

func dialog_finished():
	$AnimationPlayer.play("EndScene")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
		$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		get_tree().change_scene("res://Scenes/Cutscene/Intro.tscn")

