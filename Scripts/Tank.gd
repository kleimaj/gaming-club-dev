extends KinematicBody2D

export (PackedScene) var Bullet
export (int) var speed = 10
export (float) var gun_cooldown
var bulletSpeed = 100
var maxBulletSpeed = 2000
export (bool) var keyboardControls = true

#var ammo_texture = "res://Assets/GFX/Projectiles/bullet1/1-01.png"
var spriteAnim = "red"
var velocity = Vector2()
var can_shoot = true

onready var line = $Line2D
onready var muzzle = $Muzzle/Position2D

export var MAX_POINTS = 500

var changemuzzle = false

func _ready():
	$ShootTimer.wait_time = gun_cooldown

func control(delta):
#	velocity = Vector2()
#	velocity = Vector2((get_viewport().get_mouse_position() - position).x,0)
	
	if changemuzzle == false:
		if not keyboardControls:
			position.x += (get_global_mouse_position().x - position.x)/6
		#Stop the tank from moving out of the game scene
		if(position.x < 30):
			position.x = 30
		if(position.x > 950):
			position.x = 950
		
	if keyboardControls:	
		$Muzzle.look_at(get_global_mouse_position())
		velocity = Vector2()
		if Input.is_action_pressed('forward'):
			velocity = Vector2(speed, 0)
		if Input.is_action_pressed('back'):
			velocity = Vector2(-speed, 0)
	if Input.is_action_just_pressed('click') || changemuzzle == true:
		changemuzzle = true
		if bulletSpeed != maxBulletSpeed:
			bulletSpeed += 5
#		$Muzzle.look_at(get_global_mouse_position())
		update_trajectory(delta)
	if Input.is_action_just_released("click"):
		changemuzzle = false
		shoot()
		bulletSpeed = 100
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
	line.clear_points()
	$ShootTimer.start()
	var b = Bullet.instance()
	#b.get_node("Sprite").frames.load_path = ammo_texture
	b.get_node("AnimatedSprite").play(spriteAnim)
	owner.add_child(b)
	b.transform = muzzle.global_transform
	b.velocity = b.transform.x * bulletSpeed
	b.gravity = 250

func update_trajectory(delta):
	line.clear_points()
	var pos = muzzle.global_position
	var vel = muzzle.global_transform.x * bulletSpeed
	for i in MAX_POINTS:
		line.add_point(pos)
		vel.y += 2.5
		pos += vel
		if pos.y > position.y:
			break
#		velocity.y += delta * 10
#		pos += velocity * delta

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
