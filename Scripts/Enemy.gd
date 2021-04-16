extends Area2D

# Rate at which mist decreases (this may be calcualted by total number of enemies)
export var mistFactor = 0.04

export var BOUNCE_MULTIPLIER = 2.5
export var isTutorial = false

signal tutorial_hit

const CollisionMap = {
	# yellow can heal spotted mushrooms
	"Yellow": ["BlueSpotted", "GreenSpotted"],
	# pink can heal non-spotted mushrooms
	"Red": ["Blue", "Green"] 
}

const MaxMedShots = {
	"Blue" : 1.0,
	"BlueSpotted" : 1.0,
	"Green" : 2.0,
	"GreenSpotted" : 2.0
}

onready var Blue = preload("res://Assets/GFX/new/MainGame_Mushroom/Blue_Tree_Mushroom/BlueMR_After_Middle_V2.png")
onready var Green = preload("res://Assets/GFX/new/MainGame_Mushroom/Green_Tree_Mushroom/GreenMR_After_Middle_V2.png")
onready var BlueSpotted = preload("res://Assets/GFX/new/MainGame_Mushroom/Blue_Tree_Spotted_Mushroom/BlueMRspotted_After_Middle_V2.png")
onready var GreenSpotted = preload("res://Assets/GFX/new/MainGame_Mushroom/Green_Tree_Spotted_Mushroom/GreenMRspotted_After_Middle.png")
onready var CureMushroomAnimation = preload("res://Scenes/MushroomCure.tscn")


#For med splash animation
const MedSplashEffect = preload("res://Scenes/Tank/MedSplash.tscn")

onready var progressBar = get_node("../../CanvasLayer2/ProgressBar")

onready var mist_obj = get_parent().get_parent().get_node("CanvasLayer3/MistCanvas/BackgroundMist")
onready var mist_tinge_obj = get_parent().get_parent().get_node("CanvasLayer3/MistCanvas/BMTinge")

#var beenHit:bool = false
var noOfMedShots:int = 0 setget setMedShots 

var start_point = 0.0
var middle_point = 0.0
var end_point = 0.0
var wobble_speed = 1
var mState
onready var original_rotation_degrees = global_rotation_degrees

enum {
	FORWARD,
	BACKWARD,
	STOP
}
	
	
func _ready():
	_animate_mushroom()
	
func getTexture(mType):
	if mType == "Blue":
		return Blue
	elif mType == "Green":
		return Green
	elif mType == "BlueSpotted":
		return BlueSpotted
	elif mType == "GreenSpotted":
		return GreenSpotted
			


func _animate_mushroom():
	rand_seed(rand_range(0,3))
	start_point = rand_range((original_rotation_degrees - 4.5 ),(original_rotation_degrees - 2.0))
	middle_point = rand_range((original_rotation_degrees+1.0),(original_rotation_degrees + 3.5))
	end_point = rand_range((original_rotation_degrees - 4.5 ),(original_rotation_degrees - 2.0))
	rotation_degrees = start_point
	mState = int(rand_range(0,1))
	wobble_speed = rand_range(0.05,0.35)
	
func _physics_process(delta):
	match mState:
		FORWARD: 
			rotation_degrees += (wobble_speed + delta)
			if rotation_degrees >= middle_point:
				mState = BACKWARD
		BACKWARD:
			rotation_degrees -= (wobble_speed + delta)
			if rotation_degrees <= end_point:
				mState = FORWARD
				_animate_mushroom()
		STOP:
			pass
				

func create_splash_effect(animType, obj):
	var splashEffect = MedSplashEffect.instance()
	get_parent().add_child(splashEffect)
	splashEffect.play(animType)
	splashEffect.global_position = obj.get_node("Position2D").global_position
	splashEffect.rotation_degrees = $Position2D.rotation_degrees
	#Add bubbles on the mushroom after hit
	var MedBubble = load("res://Scenes/" + animType +".tscn")
	var bubble = MedBubble.instance()
	add_child(bubble)
	bubble.global_position = obj.get_node("Position2D").global_position
	bubble.rotation_degrees = $Position2D.rotation_degrees



func diminish_shader():
	# Fetch Mist Sprite
	#var mist:Sprite = get_tree().get_root().get_node("Game").get_node("Mist")
	# Get ShaderMaterial from Sprite
	#var mat:ShaderMaterial = mist.material
	# Get the ScaleParameter (as a Variant)
	#var scale = mat.get_shader_param("scaleParam")
	# Decrement by mistFactor
	#scale -= mistFactor
	# Set new ScaleParameter
	#mat.set_shader_param("scaleParam", scale)
	if mist_obj.modulate.a >= 0.0:
		mist_obj.modulate.a -= mistFactor
		mist_tinge_obj.modulate.a -= mistFactor
	
func increment_shader():
	if mist_obj.modulate.a <= 1.0 : 
		mist_obj.modulate.a += mistFactor
		mist_tinge_obj.modulate.a += mistFactor

func _collision_v1(body):
	# Fetch Mist Sprite
	#var mist:Sprite = get_tree().get_root().get_node("Game").get_node("Mist")
	# Get ShaderMaterial from Sprite
	#var mat:ShaderMaterial = mist.material
	# Get the ScaleParameter (as a Variant)
	#var scale = mat.get_shader_param("scaleParam")
	# Decrement by mistFactor
	#scale -= mistFactor
	# Set new ScaleParameter
	#mat.set_shader_param("scaleParam", scale)
	var mist_obj = get_parent().get_parent().get_node("CanvasLayer3/MistCanvas/BackgroundMist")
	mist_obj.modulate.a -= mistFactor
	# Remove Enemy
	queue_free()
	# Remove Bullet
	body.free()
	

func getMaxShots(mType):
	return MaxMedShots[mType]

func setMedShots(value):
	noOfMedShots = value
	
func isHitRemaining(mType):
	return self.noOfMedShots < getMaxShots(mType)
	
func getIncrementValue(mType):
	return 1.0/getMaxShots(mType)

func register_correct_hit(anim_type,mType):
	#increment no of hits
	self.noOfMedShots += 1
	progressBar.incrementValue(getIncrementValue(mType))
	diminish_shader()
	_cure_the_mushroom(mType)
	# check is game over in Game node
	var game = get_tree().get_root().get_node("Game")
	game.incrementScore(getIncrementValue(mType))
	game.checkGameOver(anim_type)

func _on_Enemy_body_shape_entered(body_id, body: RigidBody2D, body_shape, area_shape):
#	One Way Collision
#	if body.global_position.y < global_position.y:
	body.velocity.y = -body.velocity.y * BOUNCE_MULTIPLIER
	body.velocity.x *= -(transform.get_rotation() / transform.get_rotation()) 
	# yellow or pink
	var projectile_type = body.get_meta("type")
	for group in get_groups():
		# should only iterate once
		if CollisionMap[projectile_type].has(group) and isHitRemaining(group) and not isTutorial:
			register_correct_hit(projectile_type, group)
			break
		elif isTutorial:
			if CollisionMap[projectile_type].has(group) :
				if isHitRemaining(group):
					self.noOfMedShots += 1
					_cure_the_mushroom(group)
				emit_signal("tutorial_hit")
				break
		elif group != "physics_process" and not CollisionMap[projectile_type].has(group):
			#loosing situation
			progressBar.decrementValue()
			increment_shader()
	create_splash_effect(projectile_type, body)
	body.curr_hits += 1
	if body.curr_hits == body.MAX_HITS:
		body.explode()
			
		
func _cure_the_mushroom(mushroom_type):
	if isHitRemaining(mushroom_type):
		mState = STOP
		$MushroomSpores/Particles2D.amount = 30
	else:
		mState = STOP
		var cureM = CureMushroomAnimation.instance()
		cureM.get_node("Before").texture = $Sprite.texture
		cureM.get_node("After").texture = getTexture(mushroom_type)
		add_child_below_node($Position2D,cureM)
		cureM.get_node("AnimationPlayer").play("Cure")
		$Sprite.visible = false
		rotation_degrees = original_rotation_degrees
		if yield(cureM.get_node("AnimationPlayer"), "animation_finished"):
			$MushroomSpores/Particles2D.emitting = false

