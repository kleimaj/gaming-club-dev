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


func _physics_process(delta):
	match state:
		STOP:
			pass
			
		LEFT:
			if position.x < leftLimit:
				position.x += (speed +delta)
		
		RIGHT:
			if position.x > rightLimit:
				position.x -= (speed +delta)


func move_left():
	state = LEFT
	
func move_right():
	state = RIGHT
	
func stop():
	state = STOP
	
	
	
