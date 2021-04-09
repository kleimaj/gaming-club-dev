extends Area2D

var rng = RandomNumberGenerator.new()
var Bird = load("res://Scenes/Misc/Bird.tscn")


func spawn_bird():
	var spawnedBird = Bird.instance()
	if rng.randi_range(0,1):
		spawnedBird.direction = -1
		spawnedBird.position.x = $Right.position.x
	spawnedBird.position.y = rng.randf_range($Top.position.y, $Bottom.position.y)
#	else:
	add_child(spawnedBird)


func _on_Timer_timeout():
	spawn_bird()
	$Timer.start()


func _on_Birdbox_body_exited(body):
	body.queue_free()
