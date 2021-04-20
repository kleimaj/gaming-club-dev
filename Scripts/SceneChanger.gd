extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
export var max_load_time = 10000

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	var loader = ResourceLoader.load_interactive(path)
	var current_scene = get_tree().get_current_scene()
	if current_scene == null:
		print("still null")
		current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1)
	
	
	
	if loader == null:
		print("Resource loader unable to load the resource at path")
		return
	
	var loading_bar = load("res://Scenes/LoadingBarCanvas.tscn").instance()
	
	get_tree().get_root().call_deferred('add_child',loading_bar)
	loading_bar.get_node("ProgressBar").value = 0
	var t = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() - t < max_load_time:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			#Loading Complete
			current_scene.queue_free()
			loading_bar.queue_free()
			
			var resource = loader.get_resource()
			var new_scene = resource.instance()
			get_tree().get_root().add_child(new_scene)
			get_tree().set_current_scene(new_scene)
			break
		elif err == OK:
			#Still loading
			var progress = float(loader.get_stage())/loader.get_stage_count()
			loading_bar.get_node("ProgressBar").value = progress * 100
			#print(progress)
		else:
			print("Error while loading file")
			break
		yield(get_tree(),"idle_frame")
		
	
	
