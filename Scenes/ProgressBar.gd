extends TextureProgress



func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	value += 25

func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	value -= 25

func incrementValue(amount=25):
	value += amount

func decrementValue(amount=25):
	value -= amount
