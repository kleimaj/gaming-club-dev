extends "res://Scripts/Cutscene.gd"

# Cutscene dialogue is an array of dictionaries
var first_dialogue = [
	{
		'name': null,
		'content': 'Hello there, welcome to the game! Please click to continue!',
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
# bool to check if the first dialogue has finished
var first_finished = false

func _ready():
	$AnimationPlayer.play("BeginScene")

func _on_Button_pressed():
	$AnimationPlayer.play("FadeOutCanvas")

func dialog_finished():
	if not first_finished:
		$AnimationPlayer.play("zoom-in2")
		first_finished = true
	else:
		$AnimationPlayer.play("EndScene")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOutCanvas":
		$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
		$CanvasLayer/DialogueBox.assign_dictionary(first_dialogue)
		$CanvasLayer/DialogueBox.fade_in()
		
	elif anim_name == "zoom-in2":
		$CanvasLayer/DialogueBox.assign_dictionary(second_dialogue)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		#get_tree().change_scene("res://Scenes/Cutscene/MushroomHut.tscn")
		SceneChanger.goto_scene("res://Scenes/Cutscene/MushroomHut.tscn")


func _on_StartButton_pressed():
	$AnimationPlayer.play("FadeOutCanvas")
