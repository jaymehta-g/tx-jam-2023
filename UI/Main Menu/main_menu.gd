extends Node

var coin: AnimatedSprite2D
var coin_velocity: float = 0
var gravity: float = -1.0 / 15
var coin_launch: float = -21.0 / 3
var coin_active = false

var music: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	music = $"AudioStreamPlayer"
	music.finished.connect(replay.bind(music))
	pass

func replay(music: AudioStreamPlayer):
	music.playing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if coin_active:
		coin.global_position.y += coin_velocity
		
		if abs(coin_velocity) < abs(coin_launch / 5):
			coin_velocity -= gravity / 5
		else:
			coin_velocity -= gravity
		
		# Coin has landed
		if coin_velocity >= -coin_launch:
			coin_active = false
			coin.stop()
			if randi() % 2 == 0:
				coin.frame = 3 # Heads
			else:
				coin.frame = 9 # Tails
			
			$"Final Wait".start()


func _on_texture_button_pressed():
	$"CanvasLayer/MarginContainer/CenterContainer/TextureButton".visible = false
	coin = $"CanvasLayer/Coin"
	$"Initial Wait".start()
	music.finished.disconnect(replay.bind(music))
	music.playing = false
	pass # Replace with function body.


func _on_initial_wait_timeout():
	coin_active = true
	coin_velocity = coin_launch
	coin.play("Flipping")
	pass # Replace with function body.


func _on_final_wait_timeout():
	get_tree().change_scene_to_packed(ResourceManager.GAME_SCENE)
	pass # Replace with function body.
