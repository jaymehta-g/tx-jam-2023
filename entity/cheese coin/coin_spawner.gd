extends Node2D

var coin: Node2D

var coin_scene := preload("res://entity/cheese coin/cheese_coin.tscn")

@onready var timer = $"Timer"
@export var time_min: float
@export var time_max: float
var rand_wait_time: float:
	get:
		return randf_range(time_min,time_max)

func _ready() -> void:
	timer.wait_time = rand_wait_time
	timer.start()
	timer.timeout.connect(make_coin)
	
func make_coin():
	coin = coin_scene.instantiate()
	add_child(coin)
	timer.wait_time = rand_wait_time
	coin.picked.connect(timer.start)