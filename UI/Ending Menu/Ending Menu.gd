extends Node

@onready var background: TextureRect = $"CanvasLayer/TextureRect"

func _ready():
#	if Globals.players[0].death_count == Globals.players[1].death_count:
	if true:
		background.texture = load("res://UI/Ending Menu/draw.png")
		$"CanvasLayer/MarginContainer/Button".disabled = true
		$"AudioStreamPlayer".stream = load("res://Audio/Music/Next_Time-1.wav")
		$"AudioStreamPlayer".play(0)
	else:
		if Globals.players[0].type == Player.Type.P1:
			if Globals.players[0].death_count > Globals.players[1].death_count:
				background.texture = load("res://UI/Ending Menu/player_2_win.png")
			else:
				background.texture = load("res://UI/Ending Menu/player_1_win.png")
		else:
			if Globals.players[0].death_count > Globals.players[1].death_count:
				background.texture = load("res://UI/Ending Menu/player_1_win.png")
			else:
				background.texture = load("res://UI/Ending Menu/player_2_win.png")
	
	$"AudioStreamPlayer".finished.connect(func(): $"AudioStreamPlayer".playing = true)

func _on_button_pressed():
	
	print_debug("THE DOG HAS BEEN PET")
