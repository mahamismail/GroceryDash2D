class_name Draggable 
extends RigidBody2D

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		global_position = get_global_mouse_position()


