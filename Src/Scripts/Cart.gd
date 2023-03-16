extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Cart_body_entered(body):
	#Check if the left mouse button is pressed
	if !Input.is_mouse_button_pressed(BUTTON_LEFT):
		# Check if the entered body is a Draggable object
		if body is Draggable:
			body.queue_free()
