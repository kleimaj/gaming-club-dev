extends Node2D


func start_rain(rain_color):
	$CanvasLayer.get_node("raincloud6").get_node(rain_color).visible = true


