extends Area2D


func _on_GroundArea2D_body_entered(body):
	# Remove Bullet
	body.free()
	
	
