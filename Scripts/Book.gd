extends Node2D

# Page currently shown on left hand of screen
var CurrentPage = 1
var PageTexture
export(float) var PageSpeedRatio = 1


func play():
	# Bring book to view
	visible = true
	$AnimationPlayer.play("SlideIn")
	$AnimationPlayer.set_speed_scale(PageSpeedRatio/2)
	$AnimationPlayer.connect("animation_finished", self, "PlayNextAnimation")

func PageTurnNextPartA():
	$AnimationPlayer.set_speed_scale(PageSpeedRatio)	
	$AnimationPlayer.play("TurnPageNextA")

func PageTurnNextPartB():
	$AnimationPlayer.play("TurnPageNextB")

func PlayNextAnimation(AnimationJustCompleted):
	if (AnimationJustCompleted == "SlideIn"):
		PageTurnNextPartA()
	elif (AnimationJustCompleted == "TurnPageNextA"):
		PageTurnNextPartB()


func _on_Button_pressed():
	pass # Replace with function body.
