extends CanvasLayer

@export var trap_icons: Array[Texture2D]

@onready var p1_label: Label = %"P1 Label"
@onready var p2_label: Label = %"P2 Label"

@onready var p1_traps = %"ItemCounterLeft"
@onready var p2_traps = %"ItemCounterRight"

@onready var p1_deaths = %"P1 Deaths"
@onready var p2_deaths = %"P2 Deaths"

@onready var timer_display = %"Timer"

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

	SignalBus.death_count_changed.connect(func(player: Player, amount: int):
		var label: Label = p1_deaths if player.type == Player.Type.P1 else p2_deaths
		label.text = str(amount)
	)
	p1_traps.set_num_icons(0)
	p2_traps.set_num_icons(0)

func _process(delta: float) -> void:
	var timer := Globals.timer
	var total_seconds = floori(timer.time_left)
	var mins: int = total_seconds / 60
	var seconds: int = total_seconds % 60
	var text := "%s:%02d" % [mins,seconds]
	timer_display.text = text
