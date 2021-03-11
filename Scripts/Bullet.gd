extends RigidBody2D


export (int) var speed
export (float) var lifetime
export (int) var gravity = 98

var velocity = Vector2(350, 0)
	
	
func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	
func _on_Bullet_body_entered(body):
	pass
	''
func explode():
	queue_free()
	
func _on_Lifetime_timeout():
	explode()

func _on_Area2D_body_entered(body):
	print(body)
