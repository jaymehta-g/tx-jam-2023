extends Area2D

signal picked

func _on_body_entered(body:Node2D) -> void:
	if not body is Player:
		return
	var player := body as Player
	player.coin_count += 1
	picked.emit()
	queue_free()
