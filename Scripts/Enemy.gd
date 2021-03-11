extends Area2D



func _on_Area2D_body_entered(body):
	var mist:Sprite = get_tree().get_root().get_node("Game").get_node("Mist")
	var mat:ShaderMaterial = mist.material
	var scale = mat.get_shader_param("scaleParam")
	print(scale)
	scale -= .3
	mat.set_shader_param("scaleParam", scale)
	queue_free()
