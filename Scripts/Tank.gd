extends KinematicBody2D

export (PackedScene) var Bullet
export (int) var speed = 10
export (float) var gun_cooldown
var bulletSpeed = 100
var maxBulletSpeed = 2000
export (bool) var keyboardControls = true


var sprayColor = "Red"
var velocity = Vector2()
var can_shoot = true

onready var YellowLine = $YellowLine2D
onready var RedLine = $RedLine2D
onready var muzzle = $Muzzle/Position2D

export var MAX_POINTS = 500

var changemuzzle = false
var enabled = true

signal projectile_change

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
	if not enabled:
		return
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
		if get_global_mouse_position().y < 600:
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
	YellowLine.clear_points()
	RedLine.clear_points()
	$ShootTimer.start()
	var b = Bullet.instance()
	#b.get_node("Sprite").frames.load_path = ammo_texture
	b.get_node("AnimatedSprite").play(sprayColor)
	# Set projectile type (yellow or pink)
	b.set_meta("type", sprayColor)
	owner.add_child(b)
	b.transform = muzzle.global_transform
	b.velocity = b.transform.x * bulletSpeed
	b.gravity = 250
	b.get_child(0).get_child(0).remote_path = "../../../Camera2D"

func update_trajectory(delta):
	YellowLine.clear_points()
	RedLine.clear_points()
	var pos = muzzle.global_position
	var vel = muzzle.global_transform.x * bulletSpeed
	for i in MAX_POINTS:
		if sprayColor == "Yellow":
			YellowLine.add_point(pos)
		else:
			RedLine.add_point(pos)
		#line.add_point(pos)
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
	sprayColor = new_anim
	$Bottle.texture = load("res://Assets/GFX/UI/newBottles/" + new_anim + "BottleLoad.png")
	
func _on_Area2D_body_entered(body):
	pass


func _on_Backpack_projectile_change(new_anim):
	sprayColor = new_anim
	$Bottle.texture = load("res://Assets/GFX/UI/newBottles/" + new_anim + "BottleLoad.png")
	if new_anim == "Yellow":
		emit_signal("projectile_change")
