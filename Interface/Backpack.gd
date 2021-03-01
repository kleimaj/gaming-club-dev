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
	set_selected_item(selected_idx)
	# Attach gui input listeners
	for slot in grid.get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])
		# add entry to ProjectileMap
		ProjectileMap[slot.name] = ProjectileMap.size()

func slot_gui_input(event: InputEvent, slot):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			# hide the selected texture
			grid.get_child(selected_idx).get_child(0).hide()
			# set new selected index
			selected_idx = ProjectileMap[slot.name]
			set_selected_item(selected_idx)
			# emit signal

func set_selected_item(idx):
	# Show Selected Texture Rect
	grid.get_child(idx).get_child(0).show()
	# Change the selected pill
	selected_pill = grid.get_child(idx).get_child(1)
	$Background/HBoxContainer/ItemText/ItemName.bbcode_text = "[b]%s[/b]" % selected_pill.name
	$Background/HBoxContainer/ItemText/ItemDescription.bbcode_text = ItemDisplay[selected_pill.name]
