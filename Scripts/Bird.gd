extends KinematicBody2D

export var flySpeed = 250
export var fallSpeed = 250
var direction = 1
var isDead = false
var vel = Vector2()
var anim = "flying"

func _physics_process(delta):
	vel = Vector2()
	calc_vel()
	$AnimatedSprite.play(anim)
	var collision = move_and_collide(vel * delta)
	if collision:
		isDead = true

func calc_vel():
	if isDead:
		vel.y += fallSpeed
		anim = "dead"
		$AnimatedSprite.set_flip_v(true)
	elif direction == 1:
		vel.x += flySpeed
		$AnimatedSprite.set_flip_h(false)
	elif direction == -1:
		vel.x -= flySpeed
		$AnimatedSprite.set_flip_h(true)
