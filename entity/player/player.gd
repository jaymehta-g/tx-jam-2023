extends CharacterBody2D
class_name Player

@export var stats: PlayerStats
@export var input_maps: InputMaps

func _process(_delta: float) -> void:

	# debugging crap
	if position.y > 2000:
		velocity = Vector2.ZERO
		position = Vector2.ZERO
		$"State Machine".go_to_state("move")

func bounce(dir: Vector2, strength: float) -> void: # needs to be here bc
	velocity = dir.normalized() * strength			# this behavior happens regardless of state
	$"State Machine".go_to_state("bounce")			# kinda ugly but wtv
