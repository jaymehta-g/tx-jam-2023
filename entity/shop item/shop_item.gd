extends Area2D

class_name ShopItem

@export var icon_textures: Array[Texture2D]

var current_player_interacting: Player: # null if nobody there
	get:
		return current_player_interacting
	set(value):
		if current_player_interacting:
			if current_player_interacting.use.is_connected(give_to_player):
				current_player_interacting.use.disconnect(give_to_player)
		if value:
			value.use.connect(give_to_player)
		current_player_interacting = value
@onready var price_display: Control = $"Price Display"
@onready var show_hide_price: AnimationPlayer = $"Show Hide Price"

var type: TrapType.Types:
	set(value):
		type = value
		$"Sprite2D".texture = icon_textures[value]
	get: return type

const prices = {
	TrapType.Types.BOUNCER: 3,
	TrapType.Types.TRAMPOLINE: 4,
	TrapType.Types.PROPELLOR: 6,
}

var price: int:
	get:
		return price
	set(value):
		price = value
		price_display.text = price

func init(type: TrapType.Types):
	self.type=type
	price = get_price_of(type)

func get_price_of(type: TrapType.Types) -> int:
	return prices[type]

func _on_body_entered(body:Node2D) -> void:
	if not body is Player:
		return
	if current_player_interacting:
		return
	var player := body as Player
	current_player_interacting = player 
	show_hide_price.play("show")

func _on_body_exited(body:Node2D) -> void:
	if not body is Player:
		return
	var player := body as Player
	if player == current_player_interacting:
		current_player_interacting = null
		show_hide_price.play_backwards("show")

func give_to_player(player: Player):
	if player.coin_count >= price:
		player.coin_count -= price
		player.held_trap_type = type
		player.held_trap_amount = 3
		queue_free()
