extends KinematicBody2D



export var SPEED = 10


func _physics_process(delta):
	if Input.is_action_pressed('forward'):
		_roll_wheels(1)
	elif Input.is_action_pressed('back'):
	   _roll_wheels(-1)
		
			
func _roll_wheels(wheelDirection):
		if wheelDirection > 0:
			rotation_degrees +=  SPEED
		elif wheelDirection < 0:
			rotation_degrees -=  SPEED
			
