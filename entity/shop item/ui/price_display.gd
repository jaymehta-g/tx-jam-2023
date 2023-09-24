extends Control

@onready var label: Label = $"Panel/CenterContainer/HBoxContainer/Label"

var text: int:
	set(value):
		label.text = str(value)
