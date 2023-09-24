extends Node

@onready var background: TextureRect = $"CanvasLayer/TextureRect"

func _ready():
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

func _on_button_pressed():
	
	print_debug("THE DOG HAS BEEN PET")
