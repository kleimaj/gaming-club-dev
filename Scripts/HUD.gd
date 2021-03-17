extends Control

var backpackIsOpen = false
var bookIsOpen = false

onready var Backpack = $CanvasLayer/Backpack

# On default, set backpack and book visibility to false
#func _ready():
#	set_backpack(backpackIsOpen)

func _on_BackpackButton_pressed():
	backpackIsOpen  = !backpackIsOpen
	set_backpack(backpackIsOpen)

func set_backpack(isOpen: bool):
	Backpack.visible = isOpen

func close_backpack():
	Backpack.visible = false
	
func _on_BookButton_pressed():
	pass 

func _on_ExitButton_pressed():
	pass 


func _on_ProgressBar_value_changed(value):
	if value < 99:
		$CanvasLayer/ProgressBar/FinalProgress.visible = false
	else:
		$CanvasLayer/ProgressBar/FinalProgress.visible = true
