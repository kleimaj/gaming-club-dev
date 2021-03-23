extends Sprite


func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	position.y -= 25


func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	position.y += 25

func moveUp():
	position.y -= 25

func moveDown():
	position.y += 25
