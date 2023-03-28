extends Node

func _ready():
	pass # Replace with function body.

# Getting the item when it enters the cart using this function
func _on_Cart_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	var item_node = get_node(body.get_path()) #Geting the node
	var item_sprite = item_node.get_node("Sprite") #Getting the sprite
	Global.emit_signal("item_entered_cart", body)
	body.queue_free() #Removing item from the game space
