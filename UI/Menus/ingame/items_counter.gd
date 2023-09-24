extends Panel

@onready var icon_container: Node = %"HBoxContainer"
@export var fade_color: Color
@export var left := true

var icon_texture: Texture2D:
	set(value):
		for icon in icon_container.get_children():
			(icon as TextureRect).texture = value

func set_num_icons(num: int):
	for i in range(3):
		var icon := icon_container.get_children()[i] as Control
		if i < num:
			icon.visible = true
		else:
			icon.visible = false

func _process(delta: float) -> void:
	var hide: bool = false
	for player in Globals.players:
		if player.position.y > 500:
			if not left and player.position.x < 300:
				hide = true
			if left and player.position.y > 840:
				hide = true
	if hide:
		modulate = fade_color
	else:
		modulate = Color.WHITE
