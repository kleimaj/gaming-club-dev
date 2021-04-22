extends Camera2D

onready var topLeft = $LeftTop
onready var bottomRight = $RightBottom


func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x
	zoom = Vector2(0.65,0.65)
