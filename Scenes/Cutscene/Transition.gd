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

var finished = false

func _ready():
	$CanvasLayer/DialogueBox.connect("finished", self, "dialog_finished")
	$CanvasLayer/DialogueBox.assign_dictionary(dialog_dics)
	$CanvasLayer/DialogueBox.fade_in()
	enable_buttons()
	
func enable_buttons():
	for button in $Backdrop/Buttons.get_children():
		button.disabled = false
		button.connect("pressed", self, "_on_item_pressed", [button])
	print("Buttons enabled")

func dialog_finished():
	if not finished:
		$AnimationPlayer.play("BeginScene")
		finished = true
	else:
		$CanvasLayer/BookButton.show()
		enable_buttons()
		
func _on_item_pressed(button):
	print(button.name)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BeginScene":
		$CanvasLayer/DialogueBox.assign_dictionary(second_dialog)
		$CanvasLayer/DialogueBox.fade_in()
