extends "res://Scripts/Cutscene.gd"

var first_dialog = [
	{
		'name': 'Player',
		'content': 'Where am I?',
	},
]

var second_dialog = [
	{
		'name': 'Player',
		'content': 'Who are you!? Do you have any idea what’s going on here!?',
	},
	{
		'name': 'Prof. Flores',
		'content': 'I\'m Professor Flores, and it appears that you and I are trapped in my award...'
	},
	{
		'name': 'Player',
		'content': 'Eh? Wait like- in that bottle??',
	},
	{
		'name': 'Prof. Flores',
		'content': 'My award winning terrarium. You see, I’m a botanist and fungi expert.'
	},
	{
		'name': 'Prof. Flores',
		'content': 'Black spores have been wreaking havoc on my terrariums and surprisingly, those same black spores cause shrinking.'
	},
	{
		'name': 'Prof. Flores',
		'content': 'The only way for us to return to normal size is to eradicate the black spores and return my terrarium to its former glory!'
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
		'content': 'You received the Field Manual'
	},
	{
		'name': 'Player',
		'content': 'A manual?',
	},
	{
		'name': 'Prof. Flores',
		'content': 'This is not just any field manual! It contains all the knowledge I’ve cultivated through my studies.'
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
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/blueMushIcon.png"),
		"color": "#048B99",
		"description": "The blue mushroom is the most common in this terrarium. Approximately, 85-95% of a healthy terrarium includes them. [b]The mushroom lives in sunlight,[/b] but thrives in darkness, [b]1 dose of the pink spray is needed to treat it when it's dark.[/b]",
		"notes": "The blue mushroom is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections. "
	},
	"BlueSpottedMushroom": {
		"name": "Blue Spotted Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/blueSpotsMushIcon.png"),
		"color": "#048B99",
		"description": "The blue mushroom with spots is very similar to the blue mushroom without spots. [b]The mushroom lives in sunlight,[/b] but is more difficult to treat than the one without spots when it gets out of control which can occur in darkness. When it thrives in darkness, [b]1 dose of the yellow spray is needed to treat it.[/b] ",
		"notes": "The blue mushroom with spots is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options need to be considered."
	},
	"GreenMushroom": {
		"name": "Green Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/greenMushIcon.png"),
		"color": "#0E8E00",
		"description": "The green mushroom is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments,[/b] but if it thrives, [b]2 doses of the pink spray is needed to treat it.[/b]",
		"notes": "The green mushroom is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections but may need a longer duration  of treatment to eradicate the signs and symptoms."
	},
	"GreenSpottedMushroom": {
		"name": "Green Spotted Mushroom",
		"pack": false,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/greenSpotsMushIcon.png"),
		"color": "#0E8E00",
		"description": "The green mushroom with spots is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments, but is more difficult to treat than the one without spots when it gets out of control.[/b] If it thrives too much, [b]2 doses of the yellow spray is needed to treat it.[/b]",
		"notes": "The green mushroom with spots is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options become very limited but need to be considered."
	},
	"YellowSpray": {
		"name": "Yellow Spray",
		"pack": true,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle1.png"),
		"color": "#000",
		"description": "The yellow spray is used on the overgrowth of blue and green mushrooms with  spots to trigger the the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The yellow spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	},
	"PinkSpray": {
		"name": "Pink Spray",
		"pack": true,
		"collected": false,
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle2.png"),
		"color": "#000",
		"description": "The pink spray is used on the overgrowth of blue and green mushrooms to trigger the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The pink spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	}
}

var finished_count = 0

var clickable_items = 0
const MAX_CLICKABLE_ITEMS = 6

var content_map = {}
var current_page_index = 0 
var page_idx = 0

var isBagOpen  = false
var objLeft = 6 setget set_objectLeft

func _ready():
	$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
	$CanvasLayer/DialogueBox.assign_dictionary(first_dialog)
	$CanvasLayer/DialogueBox.fade_in()
	$CanvasLayer/Book.connect("book_closed", self, "book_closed_handler")
	
func enable_buttons():
	for button in $Player/Backdrop/Buttons.get_children():
		button.disabled = false
		button.connect("pressed", self, "_on_item_pressed", [button])
		button.connect("mouse_entered", self, "_on_mouse_entered", [button])
		button.connect("mouse_exited", self, "_on_mouse_exited", [button])		

func dialog_finished():
	if finished_count == 0:
		$AnimationPlayer.play("BeginScene")
		finished_count += 1
	elif finished_count == 1:
		$CanvasLayer/BookButton.show()
		$CanvasLayer/BackpackButton.show()
		finished_count += 1
		$Nav/LeftButton.show()
		$Nav/RightButton.show()
		$Nav/AnimationPlayer.play("FontFadeIn")
		_arrow_animate()
		$Player/Backdrop/Buttons.show()
		enable_buttons()
		$CanvasLayer/DialogueBox.hide()
	else:
		$CanvasLayer/BookButton.hide()
		$CanvasLayer/BackpackButton.hide()
		$AnimationPlayer.play("EndScene")
		
	
func _on_item_pressed(button):
	_game_pause(true)
	if ItemMap[button.name].collected:
		$CanvasLayer/Book.show()
		$CanvasLayer/Book.receiveItem(button.name, false)
	else:
		$CanvasLayer/Book.buttonType = null
		ItemMap[button.name].collected = true
		_object_found()
		content_map[button.name] = ItemMap.keys().find(button.name)
		if ItemMap[button.name].pack:
			$CanvasLayer/Book.buttonType = button.name
			button.hide()
			show_bottles()
		get_node("Player/Backdrop/Buttons/" + button.name +"/" + button.name + "G").hide()
		$CanvasLayer/Book.show()
		$CanvasLayer/Book.receiveItem(button.name, true)
		clickable_items += 1
		if clickable_items > 1:
			$CanvasLayer/Book/BookTexture/ArrowContainer.show()
		_reducto(button)
		button.disconnect("mouse_entered", self, "_on_mouse_entered")
		button.disconnect("mouse_exited", self, "_on_mouse_exited")
#	button.disconnect("pressed", self, "_on_item_pressed")
#	button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	
func book_closed_handler():
	if clickable_items == MAX_CLICKABLE_ITEMS:
		# finish scene
		# hide all UI items
		$Nav/LeftButton.hide()
		$Nav/RightButton.hide()
		$AnimationPlayer.stop()
		$CanvasLayer/BookButton.hide()
		$CanvasLayer/BackpackButton.hide()
		$CanvasLayer/DialogueBox.show()
		$CanvasLayer/DialogueBox.assign_dictionary(third_dialog)
		$CanvasLayer/DialogueBox.fade_in()
	else:
		_game_pause(false)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.assign_dictionary(second_dialog)
		$CanvasLayer/DialogueBox.fade_in()
	elif anim_name == "EndScene":
		get_tree().change_scene("res://Scenes/Tutorial.tscn")

func _engorgio(obj):
	var scale = obj.get_scale() * 1.25
	obj.set_scale(scale)
	
func _reducto(obj):
	var scale = obj.get_scale() / 1.25
	obj.set_scale(scale)
	
func _on_LeftButton_mouse_entered():
	if not $Nav/LeftButton.disabled:
		$AnimationPlayer.stop()
		$Player.move_left()
		_engorgio($Nav/LeftButton)


func _on_LeftButton_mouse_exited():
	if not $Nav/LeftButton.disabled:
		$Player.stop()
		_arrow_animate()
		_reducto($Nav/LeftButton)


func _on_RightButton_mouse_entered():
	if not $Nav/RightButton.disabled:
		_engorgio($Nav/RightButton)
		$Player.move_right()
		$AnimationPlayer.stop()
	
	
func _on_RightButton_mouse_exited():
	if not $Nav/RightButton.disabled:
		_reducto($Nav/RightButton)
		$Player.stop()
		_arrow_animate()

func _on_mouse_entered(button):
	_engorgio(button)

func _on_mouse_exited(button):
	_reducto(button)


func _on_bb_pressed(button):
	if button.visible:
		$CanvasLayer/Book.show()
		$CanvasLayer/Book.showPage($CanvasLayer/Book.KeyMap[button.name])
		
func _on_mouse_bb_entered(button):
	if button.visible:
		button.rect_position.y -= 40
		
		
func _on_mouse_bb_exited(button):
	if button.visible:
		button.rect_position.y += 40
		
func _game_pause(state):
	if state:
		$CanvasLayer/MistCanvas/BackgroundMist.set_speed_scale(0.0)
		$Nav/LeftButton.disabled = true
		$Nav/RightButton.disabled = true
		_arrow_animate()
	else:
		$CanvasLayer/MistCanvas/BackgroundMist.set_speed_scale(1.0)
		$Nav/LeftButton.disabled = false
		$Nav/RightButton.disabled = false
		_arrow_animate()
	


func _on_BookButton_pressed():
	if clickable_items > 0 :
		_game_pause(true)
		$CanvasLayer/Book.show()
		$CanvasLayer/Book.showPage(content_map[content_map.keys()[0]])
		page_idx = 0
		if clickable_items > 1:
			$CanvasLayer/Book/BookTexture/ArrowContainer.show()
		
			
		
func _on_LeftTButton_pressed():
	page_idx -=1
	if page_idx == -1:
		page_idx = content_map.keys().size() - 1
	$CanvasLayer/Book.showPage(content_map[content_map.keys()[page_idx]])


func _on_RightTButton_pressed():
	page_idx +=1
	if page_idx == content_map.keys().size():
		page_idx = 0
	$CanvasLayer/Book.showPage(content_map[content_map.keys()[page_idx]])
	
func _on_disable_nav(buttonTyp):
	get_node("Nav/" + buttonTyp).rect_scale = Vector2(0.05,0.05)
	get_node("Nav/" + buttonTyp).disabled = true
	_arrow_animate()
	
func _on_enable_nav(buttonTyp):
	get_node("Nav/" + buttonTyp).disabled = false
	_arrow_animate()
	


func _on_PinkSpray_pressed():
	_game_pause(true)
	$CanvasLayer/Book.show()
	$CanvasLayer/Book.receiveItem("PinkSpray", false)


func _on_YellowSpray_pressed():
	_game_pause(true)	
	$CanvasLayer/Book.show()
	$CanvasLayer/Book.receiveItem("YellowSpray", false)
	
func _arrow_animate():
	if not $Nav/LeftButton.disabled:
		$LeftArrowAnimation.play("Move")
	else:
		$LeftArrowAnimation.stop()
	
	if not $Nav/RightButton.disabled:
		$RightArrowAnimation.play("Move")
	else:
		$RightArrowAnimation.stop()


func show_bottles():
	if isBagOpen:
		if ItemMap["PinkSpray"].collected:
			$CanvasLayer/BackpackButton/PinkSpray.visible = true
		if ItemMap["YellowSpray"].collected:
			$CanvasLayer/BackpackButton/YellowSpray.visible = true
	else:
		$CanvasLayer/BackpackButton/PinkSpray.visible = false
		$CanvasLayer/BackpackButton/YellowSpray.visible = false

func _on_BackpackButton_pressed():
	if not isBagOpen:
		isBagOpen = true
		$CanvasLayer/BackpackButton.texture_normal = load("res://Assets/GFX/new/Backpack/Backpack_open.png")
		$CanvasLayer/BackpackButton/BackpackFront.visible = true
	else:
		isBagOpen = false
		$CanvasLayer/BackpackButton.texture_normal = load("res://Assets/GFX/new/Backpack/Backpack_closed_Back.png")
		$CanvasLayer/BackpackButton/BackpackFront.visible = false
	show_bottles()

func set_objectLeft(value):
	objLeft = value
	if objLeft > 0:
		$Nav/NoOfObjects.text = "Items left to find : " + str(objLeft)
		$Nav/AnimationPlayer.play("FontFadeIn")
	else:
		$Nav/NoOfObjects.text = "Nice!!! you found them all..."
		$Nav/AnimationPlayer.play("FontFadeInOut")
	
	
func _object_found():
	self.objLeft -= 1
	

