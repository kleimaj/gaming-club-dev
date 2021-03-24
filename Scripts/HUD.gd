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
	backpackIsOpen = false
	
	
#func _on_BookButton_pressed():
#	$CanvasLayer/Book.play()
