extends Control

onready var follow = $BookTexture/Path2D/PathFollow2D
onready var description = $BookTexture/HBoxContainer/RightContainer/Description
var tween

export var speed = 850

var PageMap = [
	{
		"mushroom_title": "[center]Blue Fungi[/center]",
		"mushroom_sprite": "res://Assets/GFX/UI/blueMushIcon.png",
		"juice_title": "[center]Treated by Pink Juice[/center]",
		"juice_sprite": "res://Assets/GFX/UI/newBottles/bottle2.png"
	},
	{
		"mushroom_title": "[center]Green Fungi[/center]",
		"mushroom_sprite":"res://Assets/GFX/UI/greenMushIcon.png" ,
		"juice_title": "[center]Treated by Pink Juice[/center]",
		"juice_sprite": "res://Assets/GFX/UI/newBottles/bottle2.png"
	},
	{
		"mushroom_title": "[center]Blue Spotted Fungi[/center]",
		"mushroom_sprite": "res://Assets/GFX/UI/blueSpotsMushIcon.png",
		"juice_title": "[center]Treated by Yellow Juice[/center]",
		"juice_sprite": "res://Assets/GFX/UI/newBottles/bottle1.png"
	},
	{
		"mushroom_title": "[center]Green Spotted Fungi[/center]",
		"mushroom_sprite": "res://Assets/GFX/UI/greenSpotsMushIcon.png",
		"juice_title": "[center]Treated by Yellow Juice[/center]",
		"juice_sprite": "res://Assets/GFX/UI/newBottles/bottle1.png"
	} 
]

func _ready():
	set_process(true)
	$BookTexture/HBoxContainer/RightContainer/AnimationPlayer.play("ShowDescription")

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


func _on_LeftButton_pressed():
	pass # Replace with function body.


func _on_RightButton_pressed():
	pass # Replace with function body.
