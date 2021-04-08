extends KinematicBody2D


enum{
	STOP,
	LEFT,
	RIGHT
}

var state = STOP
var speed = 5
var leftLimit = 840
var rightLimit = -480



signal disable_nav(button_type)
signal enable_nav(button_type)

func _ready():
	connect("disable_nav", get_parent(), "_on_disable_nav")
	connect("enable_nav", get_parent(), "_on_enable_nav")
	

func _physics_process(delta):
	match state:
		STOP:
			pass
			
		LEFT:
			emit_signal("enable_nav", "RightButton") 
			if position.x < leftLimit:
				position.x += (speed +delta)
			else:
				emit_signal("disable_nav", "LeftButton") 
		
		RIGHT:
			emit_signal("enable_nav", "LeftButton") 
			if position.x > rightLimit:
				position.x -= (speed +delta)
			else:
				emit_signal("disable_nav", "RightButton")  


func move_left():
	state = LEFT
	
func move_right():
	state = RIGHT
	
func stop():
	state = STOP
	

	
