extends Node

@onready var background: TextureRect = $"CanvasLayer/TextureRect"

var pets: int = 0

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
	pets += 1
	
	if pets == 1:
		$"CanvasLayer/Bruce".visible = true
		$"CanvasLayer/Program2".visible = true
	elif pets == 2:
		$"CanvasLayer/Jay".visible = true
		$"CanvasLayer/Program".visible = true
	elif pets == 3:
		$"CanvasLayer/Rach".visible = true
		$"CanvasLayer/Art".visible = true
	elif pets == 4:
		$"CanvasLayer/Karah".visible = true
		$"CanvasLayer/Music".visible = true
	elif pets == 5:
		$"CanvasLayer/Rhea".visible = true
		$"CanvasLayer/Design".visible = true
	elif pets == 6:
		$"CanvasLayer/MarginContainer2/TextureRect2".visible = true
