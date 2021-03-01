extends Control

# The Pill Texture Rect
var selected_pill = null
# The Selected Projectile Index (0, 1, or 2)
var selected_idx = 0
onready var grid = $Background/HBoxContainer/ItemGrid

# Maps the Projectiles to its indices
var ProjectileMap = {}

# Maps the Item Name to its Description
var ItemDisplay = {
	"Blue Pill": "Blue pills are best against the blue type of mushrooms!",
	"Red Pill": "Red pills are best against the red type of mushrooms!",
	"Green Pill": "Green pills are best against the green type of mushrooms!",
}

# Runs first
func _ready():
	# Show the default selected pill (pill index 0)
	# Assign selected_pill to Blue Pill (texture rect)
	set_selected(selected_idx)

func set_selected(idx):
	# Show Selected Texture Rect
	grid.get_child(idx).get_child(0).show()
	# Change the selected pill
	selected_pill = grid.get_child(idx).get_child(1)
	$Background/HBoxContainer/ItemText/ItemName.bbcode_text = "[b]%s[/b]" % selected_pill.name
	$Background/HBoxContainer/ItemText/ItemDescription.bbcode_text = ItemDisplay[selected_pill.name]
