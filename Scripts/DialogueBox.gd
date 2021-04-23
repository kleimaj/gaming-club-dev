extends Control


var dialog_dics = []

var dialog_index = 0
signal finished
var dialog_done = false
var floresDidWink = false
var indicatorHidden = false
export var dialog_locked = false
export var no_sprite = false

#func _ready():
##	load_dialog()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and dialog_dics.size() and not dialog_locked:
		load_dialog()
		set_process(false)

func _input(event):
	if event is InputEventKey and event.scancode == KEY_S and not event.echo and not dialog_locked:
		fade_out()

func assign_dictionary(dictionary):
	dialog_dics = dictionary
	dialog_index = 0

func fade_in():
	$AnimationPlayer.play("fade-in")
func fade_out():
	$AnimationPlayer.play("fade-out")
	
func load_dialog():
	$Indicator.hide()
	$Indicator/AnimationPlayer.stop()
	if dialog_index < dialog_dics.size():
		# Show Name if exists
		if dialog_dics[dialog_index].name != null:
			$NameRect.show()
			$NameRect/NameText.bbcode_text = dialog_dics[dialog_index].name
			if dialog_dics[dialog_index].name == "Cat":
				$CatRect.show()
				$AnimationPlayer.play("fade-in-cat")
				$AnimationPlayer.play("cat_meow")
				$Meow.play()
			elif dialog_dics[dialog_index].name == "Professor Flores" and not no_sprite:
				$FloresRect.show()
				if !floresDidWink:
					$AnimationPlayer.play("animate_flores")
					floresDidWink = true
		else:
			$NameRect.hide()
			if dialog_dics[dialog_index].content == 'You received the Field Manual':
				$Book.show()
				$AnimationPlayer.play("animate-book")
		$RichTextLabel.bbcode_text = dialog_dics[dialog_index].content
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		fade_out()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	if not indicatorHidden:
		$Indicator.show()
		$Indicator/AnimationPlayer.play("IDLE")
	set_process(true)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade-in":
		load_dialog()
	elif anim_name == "fade-out":
		$RichTextLabel.bbcode_text = "..."
		dialog_dics = []
		emit_signal("finished")
	elif anim_name == "cat_meow":
		$AnimationPlayer.play("animate_cat")
		
