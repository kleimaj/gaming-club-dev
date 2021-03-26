extends Area2D

# Rate at which mist decreases (this may be calcualted by total number of enemies)
export var mistFactor = 0.45

const BOUNCE_MULTIPLIER = 2.5

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

var beenHit:bool = false

func diminish_shader():
	# Fetch Mist Sprite
	var mist:Sprite = get_tree().get_root().get_node("Game").get_node("Mist")
	# Get ShaderMaterial from Sprite
	var mat:ShaderMaterial = mist.material
	# Get the ScaleParameter (as a Variant)
	var scale = mat.get_shader_param("scaleParam")
	# Decrement by mistFactor
	scale -= mistFactor
	# Set new ScaleParameter
	mat.set_shader_param("scaleParam", scale)

func _collision_v1(body):
	# Fetch Mist Sprite
	var mist:Sprite = get_tree().get_root().get_node("Game").get_node("Mist")
	# Get ShaderMaterial from Sprite
	var mat:ShaderMaterial = mist.material
	# Get the ScaleParameter (as a Variant)
	var scale = mat.get_shader_param("scaleParam")
	# Decrement by mistFactor
	scale -= mistFactor
	# Set new ScaleParameter
	mat.set_shader_param("scaleParam", scale)
	# Remove Enemy
	queue_free()
	# Remove Bullet
	body.free()
	

func register_correct_hit():
	# Signal Fog and ProgressBar
	var mist = get_node("../../evilMist")
	var progressBar = get_node("../../CanvasLayer2/ProgressBar")
	mist.moveUp(50)
	progressBar.incrementValue(34)
	diminish_shader()
	# Set beenHit to true (doesn't trigger again)
	beenHit = true
	# check is game over in Game node
	var game = get_tree().get_root().get_node("Game")
	game.incrementScore()
	game.checkGameOver()

func _on_Enemy_body_shape_entered(body_id, body: RigidBody2D, body_shape, area_shape):
	if body.global_position.y < global_position.y:
		body.velocity.y = -body.velocity.y
		body.velocity.x *= -(transform.get_rotation() / transform.get_rotation()) * BOUNCE_MULTIPLIER
		# yellow or pink
		var projectile_type = body.get_meta("type")
		for group in get_groups():
			# should only iterate once
			if CollisionMap[projectile_type].has(group) and not beenHit:
				register_correct_hit()
				break
		create_splash_effect(projectile_type, body.global_position)

