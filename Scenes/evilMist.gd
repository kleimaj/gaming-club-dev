extends Area2D

export var downSpeed = .5

func _process(delta):
	#moveDown(downSpeed)
	pass
	
func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	#position.y -= 25
	pass


func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	#position.y += 50
	pass

func moveUp(amount=25):
	#position.y -= amount
	pass

func moveDown(amount=25):
	#position.y += amount
	pass
