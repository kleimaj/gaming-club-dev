extends "res://Scripts/Cutscene.gd"

var dialog_dics = [
	{
		'name': 'Player',
		'content': 'Hello...? Is anyone in here?',
	},
	{
		'name': 'Cat',
		'content': 'Meow!',
	},
	{
		'name': 'Player',
		'content': 'Hey wait!',
	},
]

func _ready():
	$AnimationPlayer.play("BeginScene")
	

func dialog_finished():
	$CanvasLayer/Backdrop/Cat.show()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
		$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		get_tree().change_scene("res://Scenes/Cutscene/Transition.tscn")

func _on_Terrarium_pressed():
	$AnimationPlayer.play("EndScene")
