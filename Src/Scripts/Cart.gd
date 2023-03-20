extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Cart_body_entered(body):
	pass

func _on_Cart_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is Draggable:
			print("Item touched cart!")
			body.queue_free()
	
