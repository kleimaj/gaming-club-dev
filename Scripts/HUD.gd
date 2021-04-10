extends Control

var backpackIsOpen = false
var bookIsOpen = false

export var isTutorial = false

onready var Backpack = $CanvasLayer/Backpack

# On default, set backpack and book visibility to false
func _ready():
	$CanvasLayer/TransitionBook.connect("book_closed", self, "close_book")

func _on_BackpackButton_pressed():
	backpackIsOpen  = !backpackIsOpen
	set_backpack(backpackIsOpen)
	get_tree().paused = true
	$CanvasLayer/ColorRect.show()
	

func set_backpack(isOpen: bool):
	Backpack.visible = isOpen
	


func close_backpack():
	$CanvasLayer/ColorRect.hide()
	Backpack.visible = false
	backpackIsOpen = false
	get_tree().paused = false


func close_book():
	$CanvasLayer/ColorRect.hide()
	$CanvasLayer/TransitionBook.hide()
	bookIsOpen = false
	get_tree().paused = false

func _on_BookButton_pressed():
	if bookIsOpen:
		$CanvasLayer/ColorRect.hide()
		$CanvasLayer/TransitionBook.hide()
		bookIsOpen = false
		get_tree().paused = false
	else:
		$CanvasLayer/ColorRect.show()
		$CanvasLayer/TransitionBook.show()
		$CanvasLayer/TransitionBook/BookTexture/ArrowContainer.show()
		$CanvasLayer/TransitionBook/BookTexture/HBoxContainer/RightContainer/Notes.percent_visible = 1
		$CanvasLayer/TransitionBook/BookTexture/BlueMushroom/PathFollow2D/Sprite.hide()
		bookIsOpen = true
		get_tree().paused = true
		if isTutorial:
			$CanvasLayer/TransitionBook.receiveItem("BlueSpottedMushroom", false)


func _on_Backpack_close_backpack():
	close_backpack()


