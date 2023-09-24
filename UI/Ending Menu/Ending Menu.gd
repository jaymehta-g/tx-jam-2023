extends Node

@onready var background: TextureRect = $"CanvasLayer/TextureRect"

func _ready():
	if Globals.player_1_deaths == Globals.player_2_deaths:
#	if true:
		background.texture = load("res://UI/Ending Menu/draw.png")
		$"CanvasLayer/MarginContainer/Button".disabled = true
		$"AudioStreamPlayer".stream = load("res://Audio/Music/Next_Time-1.wav")
		$"AudioStreamPlayer".play(0)
	else:
		if Globals.player_1_deaths > Globals.player_2_deaths:
			background.texture = load("res://UI/Ending Menu/player_1_win.png")
		else:
			background.texture = load("res://UI/Ending Menu/player_2_win.png")
	
	$"AudioStreamPlayer".finished.connect(func(): $"AudioStreamPlayer".playing = true)

func _on_button_pressed():
	
	print_debug("THE DOG HAS BEEN PET")
