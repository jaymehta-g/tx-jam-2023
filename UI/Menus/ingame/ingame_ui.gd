extends CanvasLayer

@export var trap_icons: Array[Texture2D]

@onready var p1_label: Label = %"P1 Label"
@onready var p2_label: Label = %"P2 Label"

@onready var p1_traps = %"ItemCounterLeft"
@onready var p2_traps = %"ItemCounterRight"

func _ready() -> void:
	SignalBus.coin_counter_change.connect(func(player: Player, amount: int):
		var label := p1_label if player.type == Player.Type.P1 else p2_label
		label.text = str(amount)
	)

	SignalBus.trap_change.connect(func(player: Player, type: int):
		var icons = p1_traps if player.type == Player.Type.P1 else p2_traps	
		icons.icon_texture = trap_icons[type]
	)

	SignalBus.trap_amount_changed.connect(func(player: Player, amnt: int):
		var icons = p1_traps if player.type == Player.Type.P1 else p2_traps	
		icons.set_num_icons(amnt)
	)
	p1_traps.set_num_icons(0)
	p2_traps.set_num_icons(0)
