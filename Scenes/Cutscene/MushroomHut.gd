extends "res://Scripts/Cutscene.gd"

var dialog_dics = [
	{
		'name': '[center]Player[/center]',
		'content': 'Hello...? Is anyone in here?',
	},
	{
		'name': '[center]Cat[/center]',
		'content': 'Meow!',
	},
	{
		'name': '[center]Player[/center]',
		'content': 'Hey wait!',
	},
]

func _ready():
	$AnimationPlayer.play("BeginScene")
	

func dialog_finished():
	$CanvasLayer/Backdrop/Cat.show()
	$CanvasLayer/Button/Glow.show()
	$CanvasLayer/arrow.show()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
		$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		get_tree().change_scene("res://Scenes/Cutscene/Transition.tscn")

func _on_Terrarium_pressed():
	$AnimationPlayer.play("EndScene")


func _on_Terrarium_mouse_entered():
	$CanvasLayer/Button/Terrarium.set_scale(Vector2(1.05,1.05))
	var pos = $CanvasLayer/Button/Terrarium.get_position()
	$CanvasLayer/Button/Terrarium.set_position(Vector2(pos.x-3.0,pos.y-6.0))


func _on_Terrarium_mouse_exited():
	$CanvasLayer/Button/Terrarium.set_scale(Vector2(1.0,1.0))
	var pos = $CanvasLayer/Button/Terrarium.get_position()
	$CanvasLayer/Button/Terrarium.set_position(Vector2(pos.x+3.0,pos.y+6.0))
