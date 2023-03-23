extends Node

signal item_entered_cart(item)
var inventory = preload("res://Src/UserInterface/Inventory/Inventory.tres")
var item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Cart_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	item = body
	var item_node = get_node(body.get_path()) # Get the Node object for the body
	var _item_sprite = item_node.get_node("Sprite") # Access the Sprite child node of the body
	
	inventory.add_item(item)
	emit_signal("item_entered_cart",[item])
	item.queue_free()
