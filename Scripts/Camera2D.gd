extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight

export var ZOOM_SPEED = 0.10
export var ZOOM_OFFSET = 50
export var LOWER_LIMIT = 1
export var UPPER_LIMIT = 3



func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x


func _input(event):
	if event is InputEventMouseButton and Input.is_action_pressed("ZoomIn"):
		zoom.x -= ZOOM_SPEED
		zoom.y -= ZOOM_SPEED
		if(zoom.x < LOWER_LIMIT):
			zoom.x = LOWER_LIMIT
			zoom.y = LOWER_LIMIT
		else:
			limit_left += ZOOM_OFFSET
			limit_right -= ZOOM_OFFSET
		smoothing_enabled = true
		smoothing_speed = 20
	elif event is InputEventMouseButton and Input.is_action_pressed("ZoomOut"):
		zoom.x += ZOOM_SPEED
		zoom.y += ZOOM_SPEED
		if(zoom.x > UPPER_LIMIT):
			zoom.x = UPPER_LIMIT
			zoom.y = UPPER_LIMIT
		else:
			limit_left -= ZOOM_OFFSET
			limit_right +=ZOOM_OFFSET
		smoothing_enabled = true
		smoothing_speed = 5
	
