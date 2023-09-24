extends CharacterBody2D
class_name Player

"""
MOST behavior is delegated to States via State Machine
Shared behavior, like going to bounce, or values that need to be tracked always,
like checking dash direction, go here
"""

@export var stats: PlayerStats
@export var input_maps: InputMaps

@export var dbg_color: Color

@export var respawn_location: Node2D

@export var type: Type

var facing_right: bool
var facing_right_multiplier: int:
	get:
		return 1 if facing_right else -1
var can_dash := false

var current_state: State:
	get:
		return $"State Machine".current_state

@export var held_trap_type: TrapType.Types
var held_trap_amount: int = 0

var coin_count: int:
	get:
		return coin_count
	set(value):
		coin_count = value
		SignalBus.coin_counter_change.emit(self, coin_count)

enum Type {P1, P2}

@onready var boing_sfx: AudioStreamPlayer = $"Boing Player"
@onready var fall_sfx: AudioStreamPlayer = $"Metal Pipe Player"

signal add_to_level(node: Node)
signal use(player: Player) # pass in self to show who used

func _ready() -> void:
	if $Sprite2D:
		$Sprite2D.modulate = dbg_color
	coin_count = coin_count # to update the counters

func _process(_delta: float) -> void:
	if Input.is_action_pressed(input_maps.left):
		facing_right = false
	if Input.is_action_pressed(input_maps.right):
		facing_right = true	
	if $Sprite2D:
		$Sprite2D.scale.x = abs($Sprite2D.scale.x) * facing_right_multiplier
	# debugging crap
	if position.y > 2000:
		velocity = Vector2.ZERO
		if respawn_location: position= respawn_location.position
		else: position = Vector2.ZERO
		$"State Machine".go_to_state("move")

func bounce(dir: Vector2, strength: float) -> void: # needs to be here bc
	velocity = dir.normalized() * strength			# this behavior happens regardless of state
	$"State Machine".go_to_state("bounce")			# kinda ugly but wtv

func play_pipe() -> void:
	var funny: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(funny)
	funny.stream = load("res://Audio/Sound Effects/Metal Pipe.wav")
	funny.pitch_scale = randf_range(0.5, 1.5)
	funny.volume_db = -25
	funny.play(0)
	funny.finished.connect(func(): funny.queue_free())

func play_bounce() -> void:
	var funny: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(funny)
	funny.stream = load("res://Audio/Sound Effects/boing.wav")
	funny.volume_db = -10
	funny.play(0)
	funny.finished.connect(func(): funny.queue_free())
