extends Area2D

@export var strength: float
var durability = 3

func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		var player := body as Player
		var bounce_dir = player.position - position 
		player.bounce(bounce_dir, strength)

		durability -= 1
		if durability <= 0:
			queue_free()