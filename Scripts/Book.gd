extends Control

onready var follow = $BookTexture/Path2D/PathFollow2D
onready var description = $BookTexture/HBoxContainer/RightContainer/Description

export var speed = 750

func _ready():
	set_process(true)
	show_book_description()

func _process(delta):
	follow.set_offset(follow.get_offset() + speed * delta)

func show_book_description():
	pass
