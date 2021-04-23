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
	$AnimationPlayer.play("BeginScene2")
	

func dialog_finished():
	$Backdrop/Cat.show()
	$Backdrop/Cat/CatAnimation.play("animate_cat")
	$Backdrop/Button/Glow.show()
	$Backdrop/Button/arrow.show()
	$Backdrop/Button/Camera_Animation.play("Zoom_In")
	$Backdrop/Button/Terrarium.disabled = false
	$Backdrop/Button/Terrarium.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene2":
		$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
		$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		#get_tree().change_scene("res://Scenes/Cutscene/Transition.tscn")
		SceneChanger.goto_scene("res://Scenes/Cutscene/Transition.tscn")

func _on_Terrarium_pressed():
	$EnteringBox.play()
	$AnimationPlayer.play("EndScene")


func _on_Terrarium_mouse_entered():
	if not $Backdrop/Button/Terrarium.disabled:
		$Backdrop/Button/Terrarium.set_scale(Vector2(1.30,1.05))
		var pos = $Backdrop/Button/Terrarium.get_position()
		$Backdrop/Button/Terrarium.set_position(Vector2(pos.x-3.0,pos.y-6.0))


func _on_Terrarium_mouse_exited():
	if not $Backdrop/Button/Terrarium.disabled:
		$Backdrop/Button/Terrarium.set_scale(Vector2(1.25,1.0))
		var pos = $Backdrop/Button/Terrarium.get_position()
		$Backdrop/Button/Terrarium.set_position(Vector2(pos.x+3.0,pos.y+6.0))


func _on_Cat_pressed():
	$Backdrop/Cat/Meow.play()
	$Backdrop/Cat/CatAnimation.play("meow_cat")


func _on_CatAnimation_animation_finished(anim_name):
	if anim_name == "meow_cat":
		$Backdrop/Cat/CatAnimation.play("animate_cat")
