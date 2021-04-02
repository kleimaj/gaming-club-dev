extends Control


var dialog_dics = []

var dialog_index = 0
signal finished

#func _ready():
##	load_dialog()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and dialog_dics.size():
		load_dialog()

func assign_dictionary(dictionary):
	dialog_dics = dictionary
	dialog_index = 0

func fade_in():
	$AnimationPlayer.play("fade-in")
func fade_out():
	$AnimationPlayer.play("fade-out")
	
func load_dialog():
	$Indicator.hide()
	if dialog_index < dialog_dics.size():
		# Show Name if exists
		if dialog_dics[dialog_index].name != null:
			$NameRect.show()
			$NameRect/NameText.bbcode_text = dialog_dics[dialog_index].name
			if dialog_dics[dialog_index].name == "[center]Cat[/center]":
				$CatRect.show()
				$AnimationPlayer.play("fade-in-cat")
			elif dialog_dics[dialog_index].name == "[center]Prof. Flores[/center]" or dialog_dics[dialog_index].name == "[center]???[/center]":
				$FloresRect.show()
		else:
			$NameRect.hide()
		$RichTextLabel.bbcode_text = dialog_dics[dialog_index].content
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		fade_out()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	$Indicator.show()
	$Indicator/AnimationPlayer.play("IDLE")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade-in":
		load_dialog()
	elif anim_name == "fade-out":
		$RichTextLabel.bbcode_text = "..."
		dialog_dics = []
		emit_signal("finished")
		
