extends Control

# The Pill Texture Rect
var selected_pill = null
var selected_anim = null
# The Selected Projectile Index (0, 1, or 2)
var selected_idx = 0
onready var grid = $Background/HBoxContainer/ItemGrid
onready var ExitButton = $Background/ExitButton

# Signal to change projectile
signal projectile_change(texture_path)
signal close_backpack

# Maps the Projectiles to its indices
var ProjectileMap = {}

# Maps the Item Name to its Description
var ItemDisplay = {
	"Yellow Medicine": "Yellow Medicine is best against spotted mushrooms!",
	"Pink Medicine": "Pink Medicine is best against normal mushrooms!",
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
	# Connect Signal Receiver
	connect("projectile_change", get_node("/root/Game/Tank"), "_on_texture_change")

func slot_gui_input(event: InputEvent, slot):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			# hide the selected texture
			grid.get_child(selected_idx).get_child(0).hide()
			# set new selected index
			selected_idx = ProjectileMap[slot.name]
			set_selected_item(selected_idx)
			# emit signal
			emit_signal("projectile_change", get_texture_path())

func set_selected_item(idx):
	# Show Selected Texture Rect
	grid.get_child(idx).get_child(0).show()
	# Change the selected pill
	selected_pill = grid.get_child(idx).get_child(1)
	selected_anim = grid.get_child(idx).get_child(2)
	$Background/HBoxContainer/ItemText/ItemName.bbcode_text = "[b]%s[/b]" % selected_pill.name
	$Background/HBoxContainer/ItemText/ItemDescription.bbcode_text = ItemDisplay[selected_pill.name]

func get_texture_path():
	#return selected_pill.texture.load_path
	return selected_anim.text

func _on_ExitButton_pressed():
	# Connect ExitButton to HUD.gd close()
	emit_signal("close_backpack")
	
	



func _on_RedBottle_mouse_entered():
	$RedBottle.rect_position.y -= 40.0
	
func _on_RedBottle_mouse_exited():
	$RedBottle.rect_position.y += 40.0


func _on_RedBottle_pressed():
	selected_anim.text = "Red"
	emit_signal("projectile_change", get_texture_path())
	emit_signal("close_backpack")


func _on_YellowBottle_mouse_entered():
	$YellowBottle.rect_position.y -=40


func _on_YellowBottle_mouse_exited():
	$YellowBottle.rect_position.y += 40


func _on_YellowBottle_pressed():
	selected_anim.text = "Yellow"
	emit_signal("projectile_change", get_texture_path())
	emit_signal("close_backpack")
