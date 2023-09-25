extends Node

var coin: AnimatedSprite2D
var coin_velocity: float = 0
var gravity: float = -1.0 / 15
var coin_launch: float = -21.0 / 3
var coin_active = false

var coin_call_1: AnimatedSprite2D
var coin_call_2: AnimatedSprite2D

var call_1_heads: int = 0
var call_2_heads: int = 0

const HEADS: int = 3
const TAILS: int = 9

var music: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	music = $"AudioStreamPlayer"
	music.finished.connect(replay.bind(music))
	
	coin = $"CanvasLayer/Coin"
	
	coin_call_1 = $"CanvasLayer/Coin Call 1"
	coin_call_2 = $"CanvasLayer/Coin Call 2"
	
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
				coin.frame = HEADS # Heads
			else:
				coin.frame = TAILS # Tails
			
			$"Final Wait".start()
			$"Coin Flip End".play(0)
	
	if coin_call_1.visible and coin.is_playing():
		if Input.is_action_pressed("p1_up"):
			player_1_call(true)
		elif Input.is_action_just_pressed("p1_use"):
			player_1_call(false)
		
		if Input.is_action_pressed("p2_up"):
			player_1_call(false)
		elif Input.is_action_just_pressed("p2_use"):
			player_1_call(true)
			
func player_1_call(heads: bool):
	coin_call_1.stop()
	coin_call_2.stop()
	coin_call_1.frame = HEADS if heads else TAILS
	coin_call_2.frame = TAILS if heads else HEADS

func _on_texture_button_pressed():
	$"CanvasLayer/MarginContainer/CenterContainer/TextureButton".visible = false
	
	coin_call_1.visible = true
	coin_call_2.visible = true
	
	coin_call_1.play("Flipping")
	coin_call_2.play("Flipping")
	
	$"Initial Wait".start()
	music.finished.disconnect(replay.bind(music))
	music.playing = false
	%"TXJamLabel".queue_free()


func _on_initial_wait_timeout():
	coin_active = true
	coin_velocity = coin_launch
	coin.play("Flipping")
	$"Coin Flip Start".play(0)
	pass # Replace with function body.


func _on_final_wait_timeout():
	if coin_call_1.frame == coin.frame:
		print_debug("player 1 wins")
	else:
		print_debug("player 2 wins")
	
	GameScene.player_1_boon = coin_call_1.frame == coin.frame
	get_tree().change_scene_to_packed(ResourceManager.GAME_SCENE)

