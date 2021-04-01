extends "res://Scripts/Cutscene.gd"

var dialog_dics = [
	{
		'name': 'Player',
		'content': 'Where am I?',
	},
]

var second_dialog = [
	{
		'name': '???',
		'content': 'Hmph! Not exactly who I was expecting but-',
	},
	{
		'name': 'Player',
		'content': '(startled) AAAAA!!!',
	},
	{
		'name': '???',
		'content': 'AAAA WHY ARE YOU SCREAMING??',
	},
	{
		'name': 'Player',
		'content': 'Who are you!? Do you have any idea what’s going on here!?',
	},
	{
		'name': '???',
		'content': 'Ah ah! Be calmed young friend, it appears your curiosity got the better of you! Not that I’m one to talk..',
	},
	{
		'name': 'Player',
		'content': 'Huh??',
	},
	{
		'name': 'Prof. Flores',
		'content': 'I\'m Professor Flores, and it appears that you and I are trapped!'
	},
	{
		'name': 'Player',
		'content': 'Eh? Wait like- in that bottle??',
	},
	{
		'name': 'Prof. Flores',
		'content': 'This is not just some bottle! It’s- well it WAS my award winning terrarium. You see, I’m a botanist and fungi expert.'
	},
	{
		'name': 'Prof. Flores',
		'content': 'Black spores have been wreaking havoc on my terrariums and surprisingly, those same black spores cause shrinking.'
	},
	{
		'name': 'Prof. Flores',
		'content': '[color=#000000]The only way for us to return to normal size is to eradicate the black spores and return my terrarium to its former glory![/color]'
	},
	{
		'name': 'Prof. Flores',
		'content': 'I came in here to try and find a better treatment and rebalance the ecosystem.'
	},
	{
		'name': 'Player',
		'content': 'That\'s how I got in here? I thought that was smoke! It’s billowing out into the forest, we have to stop these spores before they spread beyond control!',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Agreed, okay lets.. Wait, how did you get in here?'
	},
	{
		'name': 'Player',
		'content': 'I was walking to a gynecology conference when...',
	},
	{
		'name': 'Prof. Flores',
		'content': 'Nevermind that then, here take this!'
	},
	{
		'name': null,
		'content': 'You received a Book'
	},
	{
		'name': 'Player',
		'content': 'A book?',
	},
	{
		'name': 'Prof. Flores',
		'content': 'This is not just any book! It contains all the knowledge I’ve cultivated through my studies.'
	},
	{
		'name': 'Prof. Flores',
		'content': 'I have it mostly committed to memory, so you can hold onto it for the time being. Here’s a pen if you have anything to add.'
	},
	{
		'name': 'Prof. Flores',
		'content': 'I’m going to scout ahead. Take a look around. I’ll come back and check on you.'
	},
]

var third_dialog = [
	{
		'name': 'Prof. Flores',
		'content': 'Come along now! I’ve set up what might be our escape from here!'
	}
]

var ItemMap = {
	"BlueMushroom": {
		"name": "Blue Mushroom",
		"pack": false,
		"sprite": load("res://Assets/GFX/UI/blueMushIcon.png"),
		"color": "#048B99",
		"description": "The blue mushroom is the most common in this terrarium. Approximately, 85-95% of a healthy terrarium includes them. [b]The mushroom lives in sunlight,[/b] but thrives in darkness, [b]1 dose of the pink spray is needed to treat it when it's dark.[/b]",
		"notes": "The blue mushroom is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections. "
	},
	"BlueSpottedMushroom": {
		"name": "Blue Spotted Mushroom",
		"pack": false,
		"sprite": load("res://Assets/GFX/UI/blueSpotsMushIcon.png"),
		"color": "#048B99",
		"description": "The blue mushroom with spots is very similar to the blue mushroom without spots. [b]The mushroom lives in sunlight,[/b] but is more difficult to treat than the one without spots when it gets out of control which can occur in darkness. When it thrives in darkness, [b]1 dose of the yellow spray is needed to treat it.[/b] ",
		"notes": "The blue mushroom with spots is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options need to be considered."
	},
	"GreenMushroom": {
		"name": "Green Mushroom",
		"pack": false,
		"sprite": load("res://Assets/GFX/UI/greenMushIcon.png"),
		"color": "#0E8E00",
		"description": "The green mushroom is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments,[/b] but if it thrives, [b]2 doses of the pink spray is needed to treat it.[/b]",
		"notes": "The green mushroom is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections but may need a longer duration  of treatment to eradicate the signs and symptoms."
	},
	"GreenSpottedMushroom": {
		"name": "Green Spotted Mushroom",
		"pack": false,
		"sprite": load("res://Assets/GFX/UI/greenSpotsMushIcon.png"),
		"color": "#0E8E00",
		"description": "The green mushroom with spots is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments, but is more difficult to treat than the one without spots when it gets out of control.[/b] If it thrives too much, [b]2 doses of the yellow spray is needed to treat it.[/b]",
		"notes": "The green mushroom with spots is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options become very limited but need to be considered."
	},
	"YellowSpray": {
		"name": "Yellow Spray",
		"pack": true,
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle1.png"),
		"color": "#000",
		"description": "The yellow spray is used on the overgrowth of blue and green mushrooms with  spots to trigger the the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The yellow spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	},
	"PinkSpray": {
		"name": "Pink Spray",
		"pack": true,
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle2.png"),
		"color": "#000",
		"description": "The pink spray is used on the overgrowth of blue and green mushrooms to trigger the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The pink spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	}
}

var finished_count = 0

var clickable_items = 0
const MAX_CLICKABLE_ITEMS = 6


func _ready():
	$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
	$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
	$CanvasLayer/DialogueBox.fade_in()
	enable_buttons()
	
func enable_buttons():
	for button in $Player/Backdrop/Buttons.get_children():
		button.disabled = false
		button.connect("pressed", self, "_on_item_pressed", [button])

func dialog_finished():
	if finished_count == 0:
		$AnimationPlayer.play("BeginScene")
		finished_count += 1
	elif finished_count == 1:
		$CanvasLayer/BookButton.show()
		$CanvasLayer/BackpackButton.show()
		finished_count += 1
		$LeftButton.show()
		$RightButton.show()
		$AnimationPlayer.play("Arrows")
		$Player/Backdrop/Buttons.show()
		enable_buttons()
	else:
		$CanvasLayer/BookButton.hide()
		$AnimationPlayer.play("EndScene")
		
func set_title(title, color):
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/ink-free-normal.ttf")
	dynamic_font.size = 38
	dynamic_font.outline_color = color
	dynamic_font.outline_size = 1
	dynamic_font.use_filter = true
	title.set("custom_fonts/normal_font", dynamic_font)
	title.add_color_override("default_color", Color(color))
func set_line_break(lineBreak, color):
	var styleBoxLine = StyleBoxLine.new()
	styleBoxLine.color = color
	styleBoxLine.thickness = 4
	lineBreak.add_stylebox_override("panel", styleBoxLine)
	
func _on_item_pressed(button):
	$CanvasLayer/Book.show()
	$CanvasLayer/Book.buttonType = null
	if ItemMap[button.name].pack:
		$CanvasLayer/Book.buttonType = button.name
		ItemMap[button.name].collected = true
	get_node("Player/Backdrop/Buttons/" + button.name +"/" + button.name + "G").hide()
	var title = $CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/VBoxContainer/MushroomContainer/MushroomTitle
	title.bbcode_text = ItemMap[button.name].name
	set_title(title, ItemMap[button.name].color)
	var lineBreak = $CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/LineBreak
	set_line_break(lineBreak, ItemMap[button.name].color)
	$CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/VBoxContainer/MushroomContainer/Mushroom.texture = ItemMap[button.name].sprite
	$CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/Description.bbcode_text = ItemMap[button.name].description
	$CanvasLayer/Book/BookTexture/HBoxContainer/RightContainer/Notes.bbcode_text = ItemMap[button.name].notes
	clickable_items += 1
	$CanvasLayer/Book/BookTexture/HBoxContainer/RightContainer/AnimationPlayer.play("ShowDescription")
	button.disconnect("pressed", self, "_on_item_pressed")
	if clickable_items == MAX_CLICKABLE_ITEMS:
		# finish scene
		$CanvasLayer/DialogueBox.assign_dictionary(third_dialog)
		$CanvasLayer/DialogueBox.fade_in()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.assign_dictionary(second_dialog)
		$CanvasLayer/DialogueBox.fade_in()

func _engorgio(obj):
	var scale = obj.get_scale() * 1.25
	obj.set_scale(scale)
	
func _reducto(obj):
	var scale = obj.get_scale() / 1.25
	obj.set_scale(scale)
	
func _on_LeftButton_mouse_entered():
	$AnimationPlayer.stop()
	$Player.move_left()
	_engorgio($LeftButton)


func _on_LeftButton_mouse_exited():
	$Player.stop()
	$AnimationPlayer.play("Arrows")
	_reducto($LeftButton)


func _on_RightButton_mouse_entered():
	_engorgio($RightButton)
	$Player.move_right()
	$AnimationPlayer.stop()
	
	
func _on_RightButton_mouse_exited():
	_reducto($RightButton)
	$Player.stop()
	$AnimationPlayer.play("Arrows")


func _on_BlueMushroom_mouse_entered():
	_engorgio($Player/Backdrop/Buttons/BlueMushroom)
	

func _on_BlueMushroom_mouse_exited():
	_reducto($Player/Backdrop/Buttons/BlueMushroom)


func _on_BlueSpottedMushroom_mouse_entered():
	_engorgio($Player/Backdrop/Buttons/BlueSpottedMushroom)


func _on_BlueSpottedMushroom_mouse_exited():
	_reducto($Player/Backdrop/Buttons/BlueSpottedMushroom)


func _on_GreenMushroom_mouse_entered():
	_engorgio($Player/Backdrop/Buttons/GreenMushroom)


func _on_GreenMushroom_mouse_exited():
	_reducto($Player/Backdrop/Buttons/GreenMushroom)


func _on_GreenSpottedMushroom_mouse_entered():
	_engorgio($Player/Backdrop/Buttons/GreenSpottedMushroom)


func _on_GreenSpottedMushroom_mouse_exited():
	_reducto($Player/Backdrop/Buttons/GreenSpottedMushroom)


func _on_YellowSpray_mouse_entered():
	_engorgio($Player/Backdrop/Buttons/YellowSpray)


func _on_YellowSpray_mouse_exited():
	_reducto($Player/Backdrop/Buttons/YellowSpray)


func _on_PinkSpray_mouse_entered():
	_engorgio($Player/Backdrop/Buttons/PinkSpray)


func _on_PinkSpray_mouse_exited():
	_reducto($Player/Backdrop/Buttons/PinkSpray)




func _on_BackpackButton_mouse_entered():
	if $CanvasLayer/BackpackButton/PinkSpray.visible:
		$CanvasLayer/BackpackButton/PinkSpray.rect_position.y -= 40
	if $CanvasLayer/BackpackButton/YellowSpray.visible:
		$CanvasLayer/BackpackButton/YellowSpray.rect_position.y -= 40


func _on_BackpackButton_mouse_exited():
	if $CanvasLayer/BackpackButton/PinkSpray.visible:
		$CanvasLayer/BackpackButton/PinkSpray.rect_position.y += 40
	if $CanvasLayer/BackpackButton/YellowSpray.visible:
		$CanvasLayer/BackpackButton/YellowSpray.rect_position.y += 40

