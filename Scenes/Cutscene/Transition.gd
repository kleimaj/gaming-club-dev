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
		'content': 'This is not just some bottle! It’s- well it WAS my award winning terrarium. You see, I’m a botanist and fungi expert. Black spores have been wreaking havoc on my terrariums and surprisingly, those same black spores cause shrinking.'
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
		'content': 'This is not just any book! It contains all the knowledge I’ve cultivated through my studies. I have it mostly committed to memory, so you can hold onto it for the time being. Here’s a pen if you have anything to add.'
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
		"name": "[center]Blue Mushroom[/center]",
		"sprite": load("res://Assets/GFX/UI/blueMushIcon.png"),
		"description": "The blue mushroom is the most common in this terrarium. Approximately, 85-95% of a healthy terrarium includes them. [b]The mushroom lives in sunlight,[/b] but thrives in darkness, [b]1 dose of the pink spray is needed to treat it when it's dark.[/b]",
		"notes": "The blue mushroom is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections. "
	},
	"BlueSpottedMushroom": {
		"name": "[center]Blue Spotted Mushroom[/center]",
		"sprite": load("res://Assets/GFX/UI/blueSpotsMushIcon.png"),
		"description": "The blue mushroom with spots is very similar to the blue mushroom without spots. [b]The mushroom lives in sunlight,[/b] but is more difficult to treat than the one without spots when it gets out of control which can occur in darkness. When it thrives in darkness, [b]1 dose of the yellow spray is needed to treat it.[/b] ",
		"notes": "The blue mushroom with spots is similar to Candida albicans. Approximately, 85-95% of yeast cultured in a healthy vagina is Candida albicans. An overgrowth of this common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options need to be considered."
	},
	"GreenMushroom": {
		"name": "[center]Green Mushroom[/center]",
		"sprite": load("res://Assets/GFX/UI/greenMushIcon.png"),
		"description": "The green mushroom is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments,[/b] but if it thrives, [b]2 doses of the pink spray is needed to treat it.[/b]",
		"notes": "The green mushroom is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Fungistatic drugs which can be topical or oral are commonly used to treat these infections but may need a longer duration  of treatment to eradicate the signs and symptoms."
	},
	"GreenSpottedMushroom": {
		"name": "[center]Green Spotted Mushroom[/center]",
		"sprite": load("res://Assets/GFX/UI/greenSpotsMushIcon.png"),
		"description": "The green mushroom with spots is the least common fungi in this terrarium. Rarely is it seen in a healthy terrarium. [b]The mushroom thrives in dark environments, but is more difficult to treat than the one without spots when it gets out of control.[/b] If it thrives too much, [b]2 doses of the yellow spray is needed to treat it.[/b]",
		"notes": "The green mushroom with spots is similar to Candida non-albicans. It is rarely present in a healthy vagina. An overgrowth of this less common yeast caused by an imbalance in the vagina can result in an infection. Although certain fungistatic drugs which can be topical or oral may be used, resistance to certain drugs can occur. Other treatment options become very limited but need to be considered."
	},
	"YellowSpray": {
		"name": "[center]Yellow Spray[/center]",
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle1.png"),
		"description": "The yellow spray is used on the overgrowth of blue and green mushrooms with  spots to trigger the the stopping of spores to fend off the dark mist. Sometimes certain mushrooms need more spray for a longer duration of time to be effective.",
		"notes": "The yellow spray is similar to various fungistatic drugs which can be topical or oral. Patients may develop a resistance to this drug resulting in the need for longer duration of treatment"
	},
	"PinkSpray": {
		"name": "[center]Pink Spray[/center]",
		"sprite": load("res://Assets/GFX/UI/newBottles/bottle2.png"),
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
	for button in $Backdrop/Buttons.get_children():
		button.disabled = false
		button.connect("pressed", self, "_on_item_pressed", [button])

func dialog_finished():
	if finished_count == 0:
		$AnimationPlayer.play("BeginScene")
		finished_count += 1
	elif finished_count == 1:
		$CanvasLayer/BookButton.show()
		enable_buttons()
		finished_count += 1		
	else:
		$AnimationPlayer.play("EndScene")
		
func _on_item_pressed(button):
	$CanvasLayer/Book.show()
	$CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/MushroomTitle.bbcode_text = ItemMap[button.name].name
	$CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/MushroomContainer/Mushroom.texture = ItemMap[button.name].sprite
	$CanvasLayer/Book/BookTexture/HBoxContainer/LeftContainer/Description.bbcode_text = ItemMap[button.name].description
	$CanvasLayer/Book/BookTexture/HBoxContainer/RightContainer/Notes.bbcode_text = ItemMap[button.name].notes
	clickable_items += 1
	button.disconnect("pressed", self, "_on_item_pressed")
	if clickable_items == MAX_CLICKABLE_ITEMS:
		# finish scene
		$CanvasLayer/DialogueBox.assign_dictionary(third_dialog)
		$CanvasLayer/DialogueBox.fade_in()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.assign_dictionary(second_dialog)
		$CanvasLayer/DialogueBox.fade_in()
