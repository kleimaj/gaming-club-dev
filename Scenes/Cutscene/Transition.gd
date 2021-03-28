extends "res://Scripts/Cutscene.gd"

func _ready():
	$AnimationPlayer.play("BeginScene")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		pass
