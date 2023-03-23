extends Node

signal item_entered_cart(item)
var inventory = preload("res://Src/UserInterface/Inventory/Inventory.tres")
var item

func _ready():
	pass # Replace with function body.

# Getting the item when it enters the cart using this function
func _on_Cart_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	item = body
	var item_node = get_node(body.get_path()) #Geting the node
	var _item_sprite = item_node.get_node("Sprite") #Getting the sprite
	
	inventory.add_item(item) #Adding item to inventory
	#emit_signal("item_entered_cart",[item])
	item.queue_free() #Removing item from the game space
