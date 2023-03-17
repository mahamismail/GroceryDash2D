extends RigidBody2D

var selected = false
var velocity = get_linear_velocity()
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
		else:
			selected = false
