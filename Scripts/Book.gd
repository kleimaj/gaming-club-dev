extends Control

onready var follow = $BookTexture/Path2D/PathFollow2D
onready var description = $BookTexture/HBoxContainer/RightContainer/Description
var tween

export var speed = 850

func _ready():
	set_process(true)
#	show_book_description()

func _process(delta):
#	follow.set_offset(follow.get_offset() + speed * delta)
	pass

func animatePencil():
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(follow, "unit_offset", 0, 1, 6, tween.TRANS_LINEAR, tween.EASE_IN_OUT)

#func show_book_description():
#	description.percent_visible = 0
#	$BookTexture/WritingTween.interpolate_property($BookTexture/HBoxContainer/RightContainer/Description, "percent_visible", 0, 1, 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#	$BookTexture/WritingTween.start()
