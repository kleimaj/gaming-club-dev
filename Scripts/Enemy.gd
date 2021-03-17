extends Area2D

# Rate at which mist decreases (this may be calcualted by total number of enemies)
export var mistFactor = 0.3

func _collision_v1(body):
	# Fetch Mist Sprite
	var mist:Sprite = get_tree().get_root().get_node("Game").get_node("Mist")
	# Get ShaderMaterial from Sprite
	var mat:ShaderMaterial = mist.material
	# Get the ScaleParameter (as a Variant)
	var scale = mat.get_shader_param("scaleParam")
	# Decrement by mistFactor
	scale -= mistFactor
	# Set new ScaleParameter
	mat.set_shader_param("scaleParam", scale)
	# Remove Enemy
	queue_free()
	# Remove Bullet
	body.free()
	

func _on_Enemy_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.global_position.y < global_position.y:
		print("COLLISION")
