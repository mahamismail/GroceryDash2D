class_name Draggable 
extends RigidBody2D

var selected = false
var velocity = get_linear_velocity()
onready var collision_shape = $CollisionBody

#store velocity in another variable. Update it when needed.
func _ready():
	pass
	
func _process(delta):
	if selected:
		followMouse()
	else:
		velocity = Vector2(0,0)
		

func followMouse():
	position = get_global_mouse_position()
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.pressed:
				selected = true
				mode = MODE_RIGID;
				set_collision_layer_bit(6, true)
			else:
				selected = false
				
			
#stop the item from rotating wildly.
func _integrate_forces(state):
	self.rotation_degrees = 0

#if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
#		if event.pressed:
#			selected = true
#			mode = MODE_RIGID;
#		else:
#			selected = false	
	
