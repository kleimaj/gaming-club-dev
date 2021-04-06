extends Area2D

# Rate at which mist decreases (this may be calcualted by total number of enemies)
export var mistFactor = 0.08

export var BOUNCE_MULTIPLIER = 2.5
export var isTutorial = false

signal tutorial_hit

const CollisionMap = {
	# yellow can heal spotted mushrooms
	"Yellow": ["Blue Spotted", "Green Spotted"],
	# pink can heal non-spotted mushrooms
	"Red": ["Blue", "Green"] 
}

#For med splash animation
const MedSplashEffect = preload("res://Scenes/Tank/MedSplash.tscn")

func create_splash_effect(animType, animPosition):
	var splashEffect = MedSplashEffect.instance()
	get_parent().add_child(splashEffect)
	splashEffect.play(animType)
	splashEffect.global_position = animPosition
	splashEffect.rotation_degrees = $Position2D.rotation_degrees
	#Add bubbles on the mushroom after hit
	var MedBubble = load("res://Scenes/" + animType +".tscn")
	var bubble = MedBubble.instance()
	get_parent().add_child(bubble)
	bubble.position = animPosition
	bubble.position.y = animPosition.y + 15
	bubble.rotation_degrees = $Position2D.rotation_degrees

var beenHit:bool = false

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
	var mist_obj = get_parent().get_parent().get_node("CanvasLayer3/MistCanvas/BackgroundMist")
	mist_obj.modulate.a -= mistFactor

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
	

func register_correct_hit(anim_type):
	# Signal Fog and ProgressBar
	var mist = get_node("../../emcl/evilMist")
	var progressBar = get_node("../../CanvasLayer2/ProgressBar")
	mist.moveUp(50)
	progressBar.incrementValue(13)
	diminish_shader()
	# Set beenHit to true (doesn't trigger again)
	beenHit = true
	# check is game over in Game node
	var game = get_tree().get_root().get_node("Game")
	game.incrementScore()
	game.checkGameOver(anim_type)

func _on_Enemy_body_shape_entered(body_id, body: RigidBody2D, body_shape, area_shape):
	if body.global_position.y < global_position.y:
		body.velocity.y = -body.velocity.y * BOUNCE_MULTIPLIER
		body.velocity.x *= -(transform.get_rotation() / transform.get_rotation()) 
		# yellow or pink
		var projectile_type = body.get_meta("type")
		for group in get_groups():
			# should only iterate once
			if CollisionMap[projectile_type].has(group) and not beenHit and not isTutorial:
				register_correct_hit(projectile_type)
				break
			elif isTutorial:
				emit_signal("tutorial_hit")
		create_splash_effect(projectile_type, body.global_position)
		body.curr_hits += 1
		if body.curr_hits == body.MAX_HITS:
			body.explode()
			body.free()
			
		


