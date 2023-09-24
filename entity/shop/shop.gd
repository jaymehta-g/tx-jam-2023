extends Node2D

@export var shop_item_scene: PackedScene

@onready var item_container = $"ShopItemLocations"

var items: Array[ShopItem]

var item_positions: Array[Node2D]
var unused_positions: Array[Node2D]

func _ready() -> void:
	for child in item_container.get_children():
		if child is Node2D:
			item_positions.append(child)
			unused_positions.append(child)

func update_unused() -> void:
	unused_positions.clear()
	for marker in item_container.get_children():
		print_debug(marker.get_child_count())
		if marker.get_child_count() == 0:
			unused_positions.append(marker)
	print_debug(unused_positions)

func _timer_timeout():
	if unused_positions.size() == 0:
		return
	var array_idx := randi() % unused_positions.size()
	var new_position := unused_positions[array_idx]
	unused_positions.remove_at(array_idx)
	
	var node := shop_item_scene.instantiate() as ShopItem
	var type := TrapType.rand_type()
	new_position.add_child(node)
	node.init(type)

	node.tree_exited.connect(update_unused)