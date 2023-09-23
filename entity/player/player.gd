extends CharacterBody2D
class_name Player

"""
MOST behavior is delegated to States via State Machine
Shared behavior, like going to bounce, or values that need to be tracked always,
like checking dash direction, go here
"""

@export var stats: PlayerStats
@export var input_maps: InputMaps

var facing_right: bool
var can_dash := false

signal add_to_level(node: Node)

func _process(_delta: float) -> void:
	if Input.is_action_pressed(input_maps.left):
		facing_right = false
	if Input.is_action_pressed(input_maps.right):
		facing_right = true	
	if $Sprite2D:
		$Sprite2D.scale.x = abs($Sprite2D.scale.x) * (1 if facing_right else -1)
	# debugging crap
	if position.y > 2000:
		velocity = Vector2.ZERO
		position = Vector2.ZERO
		$"State Machine".go_to_state("move")

func bounce(dir: Vector2, strength: float) -> void: # needs to be here bc
	velocity = dir.normalized() * strength			# this behavior happens regardless of state
	$"State Machine".go_to_state("bounce")			# kinda ugly but wtv
