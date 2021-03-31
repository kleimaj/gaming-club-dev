extends Node2D

var lrain = "Red"
func start_rain(rain_color):
	$CanvasLayer.get_node("raincloud6").get_node(rain_color).visible = true
	lrain = rain_color
	
func stop_rain():
	$CanvasLayer.get_node("raincloud6").get_node(lrain).one_shot = true


