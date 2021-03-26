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
	get_tree().paused = true
	

func set_backpack(isOpen: bool):
	Backpack.visible = isOpen

func close_backpack():
	Backpack.visible = false
	backpackIsOpen = false
	get_tree().paused = false
	
	
func _on_BookButton_pressed():
	if bookIsOpen:
		$CanvasLayer/Book.hide()
		bookIsOpen = false
		get_tree().paused = false
	else:
		$CanvasLayer/Book.show()
		bookIsOpen = true
		get_tree().paused = true
