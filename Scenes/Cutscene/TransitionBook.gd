extends Control

export var buttonType = "PinkSpray"

signal book_closed
signal tutorial_item_found

#keeps track of what page the user is on (index of ItemMap array)
var page_idx = 0

# Array of dictionaries for each item
var ItemMap = [
	{
		"name": "Blue Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/new/MainGame_Mushroom/BlueMushroom.png"),
		"color": "#048B99",
		"description": "The blue mushroom is the most common in this terrarium. Approximately, 85-95% of a healthy terrarium includes them. [b]The mushroom lives in sunlight,[/b] but thrives in darkness, [b]1 dose of the pink spray is needed to treat it when it's dark.[/b]",
		"notes": "The blue mushroom is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections. "
	},
	{
		"name": "Blue Spotted Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/new/MainGame_Mushroom/Blue_Sppotted_Mushroom.png"),
		"color": "#048B99",
		"description": "The blue mushroom with spots is very similar to the blue mushroom without spots. [b]The mushroom lives in sunlight,[/b] but is more difficult to treat than the one without spots when it gets out of control which can occur in darkness. When it thrives in darkness, [b]1 dose of the yellow spray is needed to treat it.[/b] ",
		"notes": "The blue mushroom with spots is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options need to be considered."
	},
	{
		"name": "Green Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/new/MainGame_Mushroom/GreenMushroom.png"),
		"color": "#0E8E00",
		"description": "The green mushroom is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments,[/b] but if it thrives, [b]2 doses of the pink spray is needed to treat it.[/b]",
		"notes": "The green mushroom is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections but may need a longer duration  of treatment to eradicate the signs and symptoms."
	},
	{
		"name": "Green Spotted Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/new/MainGame_Mushroom/Green_Sppotted_Mushroom.png"),
		"color": "#0E8E00",
		"description": "The green mushroom with spots is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments, but is more difficult to treat than the one without spots when it gets out of control.[/b] If it thrives too much, [b]2 doses of the yellow spray is needed to treat it.[/b]",
		"notes": "The green mushroom with spots is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options become very limited but need to be considered."
	},
	{
		"name": "Yellow Spray",
		"pack": true,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle1.png"),
		"color": "#000",
		"description": "The yellow spray is used on the overgrowth of blue and green mushrooms with  spots to trigger the the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The yellow spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	},
	{
		"name": "Pink Spray",
		"pack": true,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle2.png"),
		"color": "#000",
		"description": "The pink spray is used on the overgrowth of blue and green mushrooms to trigger the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The pink spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	}
]

var KeyMap = {
	"BlueMushroom": 0,
	"BlueSpottedMushroom": 1,
	"GreenMushroom": 2,
	"GreenSpottedMushroom": 3,
	"YellowSpray": 4,
	"PinkSpray": 5
}

# Changes Mushroom Title (sets new color and outline color)
func set_title(title, color):
	# creates dynamic font
#	var dynamic_font = DynamicFont.new()
#	dynamic_font.font_data = load("res://Fonts/ink-free-normal.ttf")
#	dynamic_font.size = 38
#	dynamic_font.outline_color = color
#	dynamic_font.outline_size = 1
#	dynamic_font.use_filter = true
#	# set title to new dynamic font (with new assigned color)
#	title.set("custom_fonts/normal_font", dynamic_font)
	title.add_color_override("default_color", Color(color))

# Changes color of LineBreak
func set_line_break(lineBreak, color):
	# creates new StyleBoxLine
	var styleBoxLine = StyleBoxLine.new()
	styleBoxLine.color = color
	styleBoxLine.thickness = 4
	# sets LineBreak to new StyleBoxLine
	lineBreak.add_stylebox_override("panel", styleBoxLine)

# Close Button Listener
func _on_Button_pressed():
	# hide book, emit book-closed signal
	hide()
	emit_signal("book_closed")
	get_tree().paused = false
	emit_signal("tutorial_item_found")
	play_open_close_book_sound()
#	if buttonType != null:
#		get_parent().get_parent().get_node("Player/Backdrop/Buttons/"+ buttonType).hide()
#		get_parent().get_node("BackpackButton/"+ buttonType).show()

func receiveItem(item_name, playAnimation):
	showPage(KeyMap[item_name])
	if playAnimation:
		$BookTexture/HBoxContainer/RightContainer/AnimationPlayer.play("ShowDescription")

func showPage(idx):
	# set new page contents of the current page
	var pageContents = ItemMap[idx]
	var title = $BookTexture/HBoxContainer/LeftContainer/VBoxContainer/MushroomContainer/MushroomTitle
	title.bbcode_text = pageContents.name
#	set_title(title, pageContents.color)
	var lineBreak = $BookTexture/HBoxContainer/LeftContainer/LineBreak
#	set_line_break(lineBreak, pageContents.color)
	$BookTexture/HBoxContainer/LeftContainer/VBoxContainer/MushroomContainer/Mushroom.texture = pageContents.sprite
	$BookTexture/HBoxContainer/LeftContainer/Description.bbcode_text = pageContents.description
	$BookTexture/HBoxContainer/RightContainer/Notes.bbcode_text = pageContents.notes


# Turn page to the left
func _on_LeftButton_pressed():
	page_idx -=1
	if page_idx == -1:
		page_idx = 5
	showPage(page_idx)
	play_page_turn_sound()
# Turn page to the right
func _on_RightButton_pressed():
	page_idx +=1
	if page_idx == 6:
		page_idx = 0
	showPage(page_idx)
	play_page_turn_sound()
	
func play_page_turn_sound():
	$PageTurnSound.play()
func play_open_close_book_sound():
	$OpenSound.play()
