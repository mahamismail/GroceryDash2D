class_name Draggables
extends RigidBody2D
# NOTE: This RigidBodies are set to static mode so the will not move in the beginning

var selected = false 
var velocity = get_linear_velocity() #getting velocity of the rigidbody
onready var collision_shape = $CollisionBody
onready var sprite = $Sprite
onready var cost = [8, 3, 2, 5, 6]


func _ready():
	set_frame()
	
func set_frame():
	get_node("Sprite").frame = randi() % 5 # Set the frame to a random value between 0 and 4

func _process(_delta):
	if selected: #when selected is true (if draggable item clicked, it's true)
		followMouse()
	else:
		velocity = Vector2(0,0) #else keep it static

func followMouse():
	position = get_global_mouse_position() #go where the mouse goes
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	
		#when LMB is pressed
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.pressed:
				selected = true #it is selected/picked
				mode = MODE_RIGID; #set to Rigid mode to get the gravity fall.
				set_collision_layer_bit(6, true) #let the rigid body detect the ground now
			else:
				selected = false
					
#stop the item from rotating wildly.
#func _integrate_forces(_state):
#	self.rotation_degrees = 0






