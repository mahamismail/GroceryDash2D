extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# When an object enters the cart
func _on_Cart_area_entered(area):
	# Check if the left mouse button is pressed
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		# Check if the entered body is a Draggable object
		if area is Draggable:
			# Do something with the Draggable object, e.g. add it to an inventory
			area.queue_free()
