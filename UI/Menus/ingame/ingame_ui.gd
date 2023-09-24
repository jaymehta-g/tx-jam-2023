extends CanvasLayer

#all of this is temporary

@onready var p1_label: Label = %"P1 Label"
@onready var p2_label: Label = %"P2 Label"

func _ready() -> void:
	SignalBus.coin_counter_change.connect(func(player: Player, amount: int):
		var label := p1_label if player.type == Player.Type.P1 else p2_label
		label.text = str(amount)
	)
