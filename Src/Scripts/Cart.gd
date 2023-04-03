extends Node

func _ready():
	pass # Replace with function body.

# Getting the item when it enters the cart using this function
func _on_Cart_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	var item_node = get_node(body.get_path()) #Geting the node
	var item_sprite = item_node.get_node("Sprite") #Getting the sprite
	var frame = item_sprite.frame
	 
	Global.emit_signal("lose_money", Global.cost[frame])
	$ItemAdditionAnim/Label.text = str(Global.cost[frame])
	get_node("AnimationPlayer").play("ItemAdded")
	Global.emit_signal("item_entered_cart", body)
	body.queue_free() #Removing item from the game space
	
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(1.0), "timeout")
	$AudioStreamPlayer2D.stop()
