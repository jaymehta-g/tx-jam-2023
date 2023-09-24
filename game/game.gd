extends Node2D

class_name GameScene

static var player_1_boon: bool

@onready var player_1: Player = $"Player1"
@onready var player_2: Player = $"Player2"

func _ready():
	var music: AudioStreamPlayer# = $"AudioStreamPlayer"
	if music:
		music.finished.connect(func(): music.playing = true)
	
	if player_1_boon:
		player_1.coin_count += 5
	else:
		player_2.coin_count += 5
