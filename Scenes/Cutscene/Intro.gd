extends "res://Scripts/Cutscene.gd"


func _on_Button_pressed():
	$AnimationPlayer.play("FadeOutCanvas")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "FadeOutCanvas":
		$CanvasLayer/DialogueBox.fade_in()
