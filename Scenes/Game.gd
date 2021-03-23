extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

<<<<<<< Updated upstream

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
=======
func _on_ProgressBar_value_changed(value):
	$ProgressBar/FinalProgress.visible = false
	if value <= 99:
		$ProgressBar/FinalProgress.visible = false
	else:
		$ProgressBar/FinalProgress.visible = true


func _on_Mushroom2_body_shape_entered(body_id, body, body_shape, area_shape):
	pass # Replace with function body.


func _on_Mushroom_body_shape_entered(body_id, body, body_shape, area_shape):
	pass # Replace with function body.
>>>>>>> Stashed changes
