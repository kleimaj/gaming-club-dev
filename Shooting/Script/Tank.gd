extends KinematicBody2D

export (PackedScene) var Bullet
export (int) var speed
export (float) var gun_cooldown

var velocity = Vector2()
var can_shoot = true
var changemuzzle = false
func _ready():
	$ShootTimer.wait_time = gun_cooldown

func control(delta):
	
	velocity = Vector2()
	velocity = Vector2((get_viewport().get_mouse_position() - position).x,0)
#	if Input.is_action_pressed('forward'):
#		velocity = Vector2(speed, 0)
#	if Input.is_action_pressed('back'):
#		velocity = Vector2(-speed, 0)
	if Input.is_action_just_pressed('click') || changemuzzle == true:
		velocity = Vector2()
		changemuzzle = true
		$Muzzle.look_at(get_global_mouse_position())
	if Input.is_action_just_released("click"):
		changemuzzle = false
		shoot()
		
func shoot():
		$ShootTimer.start()
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $Muzzle/Position2D.global_transform
		b.velocity = b.transform.x * 800
		b.gravity = 250
		
func _physics_process(delta):
	control(delta)
	move_and_slide(velocity)

func _on_Guntimer_timeout():
	can_shoot = true



func _on_Tank_shoot():
	pass # Replace with function body.