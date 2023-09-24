extends Node

var coin: AnimatedSprite2D
var coin_velocity: float = 0
var gravity: float = -1.0 / 8
var coin_launch: float = -25.0 / 5
var coin_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if coin_active:
		coin.global_position.y += coin_velocity
		if abs(coin_velocity) < 10:
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
			


func _on_texture_button_pressed():
	$"CanvasLayer/MarginContainer/CenterContainer/TextureButton".visible = false
	coin = $"CanvasLayer/Coin"
	coin.play("Flipping")
	coin_active = true
	coin_velocity = coin_launch
	#get_tree().change_scene_to_packed(ResourceManager.GAME_SCENE)
	pass # Replace with function body.
