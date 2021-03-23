extends TextureProgress



func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	value += 25

func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	value -= 25

func incrementValue():
	value += 25

func decrementValue():
	value -= 25
