extends Panel

@onready var icon_container: Node = %"HBoxContainer"

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
