extends Node2D

class_name GameScene

static var player_1_boon: bool

@onready var player_1: Player = $"Player1"
@onready var player_2: Player = $"Player2"

func _ready():
	var music: AudioStreamPlayer = $"AudioStreamPlayer"
	if music:
		music.finished.connect(func(): music.playing = true)
	Globals.timer = Timer.new()
	add_child(Globals.timer)
	Globals.timer.wait_time = 10
	Globals.timer.one_shot = true
	Globals.timer.start()
	Globals.timer.timeout.connect(func(): get_tree().change_scene_to_packed(ResourceManager.ENDING_SCENE))
	if player_1_boon:
		player_1.coin_count += 5
	else:
		player_2.coin_count += 5
