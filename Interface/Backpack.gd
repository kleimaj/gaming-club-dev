extends Control

# The Pill Texture Rect
var selected_pill = null
# The Selected Projectile Index (0, 1, or 2)
var selected_idx = 0
onready var grid = $Background/HBoxContainer/ItemGrid

# Maps the Projectiles to its indices
var ProjectileMap = {}

var ItemText = {
	"Blue Pill": "Blue pills are best against the blue type of mushrooms!",
	"Red Pill": "Red pills are best against the red type of mushrooms!",
	"Green Pill": "Green pills are best against the green type of mushrooms!",
}


