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
	var loader = ResourceLoader.load_interactive(path)
	var current_scene = get_tree().get_current_scene()
	if current_scene == null:
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
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred('add_child',resource.instance())
			current_scene.queue_free()
			loading_bar.queue_free()
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
		
