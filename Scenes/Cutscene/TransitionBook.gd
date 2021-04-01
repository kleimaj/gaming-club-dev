extends Control

export var buttonType = "PinkSpray"


func _on_Button_pressed():
	hide()
	if buttonType != null:
		get_parent().get_parent().get_node("Player/Backdrop/Buttons/"+ buttonType).hide()
		get_parent().get_node("BackpackButton/"+ buttonType).show()

	
