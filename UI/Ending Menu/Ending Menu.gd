extends Node

@onready var background: TextureRect = $"CanvasLayer/TextureRect"

func _ready():
	
	print_debug("here")

func _on_button_pressed():
	print_debug("THE DOG HAS BEEN PET")
