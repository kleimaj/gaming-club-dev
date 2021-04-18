extends RigidBody2D


export (int) var speed
export (float) var lifetime
export (int) var gravity = 98

var velocity = Vector2(350, 0)

var curr_hits = 0
const MAX_HITS = 2
	
func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	#if(position.x < 10):
	#	queue_free()
	#if(position.x > 1000):
	#	queue_free()
	if position.y < -850:
		explode()
	
func _on_Bullet_body_entered(body):
	pass
	''
func explode():
	_reset_camera(position)
	queue_free()
	
func _on_Lifetime_timeout():
	explode()

func _on_Area2D_body_entered(body):
	print(body.name)

func _reset_camera(current_camera_position):
	var ap = get_parent().get_node("CAnimationPlayer")
	if ap != null:
		var camera_obj = get_parent().get_node("Camera2D")
		var animation = ap.get_animation("ResetCamera")
		animation.track_insert_key(0, 0.0, current_camera_position)
		ap.play("ResetCamera")
		camera_obj.smoothing_enabled = true
		camera_obj.smoothing_speed = 5
