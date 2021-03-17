extends KinematicBody2D

export (PackedScene) var Bullet
export (int) var speed
export (float) var gun_cooldown
export (int) var bulletSpeed
#var ammo_texture = "res://Assets/GFX/Projectiles/bullet1/1-01.png"
var spriteAnim = "red"
var velocity = Vector2()
var can_shoot = true

var changemuzzle = false

func _ready():
	$ShootTimer.wait_time = gun_cooldown

func control(delta):
#	velocity = Vector2()
#	velocity = Vector2((get_viewport().get_mouse_position() - position).x,0)
	
	if changemuzzle == false:
		position.x += (get_global_mouse_position().x - position.x)/6
		#Stop the tank from moving out of the game scene
		if(position.x < 30):
			position.x = 30
		if(position.x > 950):
			position.x = 950
		
	
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
#func control(delta):
#	$Muzzle.look_at(get_global_mouse_position())
#	velocity = Vector2()
#	if Input.is_action_pressed('forward'):
#		velocity = Vector2(speed, 0)
#	if Input.is_action_pressed('back'):
#		velocity = Vector2(-speed, 0)
#	if Input.is_action_just_pressed('click'):
#		shoot()

		
func shoot():
		$ShootTimer.start()
		var b = Bullet.instance()
		#b.get_node("Sprite").frames.load_path = ammo_texture
		b.get_node("AnimatedSprite").play(spriteAnim)
		owner.add_child(b)
		b.transform = $Muzzle/Position2D.global_transform
		b.velocity = b.transform.x * speed
		b.gravity = 250
		
func _physics_process(delta):
	control(delta)
	move_and_slide(velocity)

func _on_Guntimer_timeout():
	can_shoot = true

func _on_Tank_shoot():
	pass # Replace with function body.

func _on_texture_change(new_anim):
	spriteAnim = new_anim
	
	
func _on_Area2D_body_entered(body):
	pass
