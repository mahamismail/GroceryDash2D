class_name Draggables
extends RigidBody2D
# NOTE: This RigidBodies are set to static mode so the will not move in the beginning

var selected = false 
var velocity = get_linear_velocity() #getting velocity of the rigidbody
onready var collision_shape = $CollisionBody
onready var sprite = $Sprite

var isThrown = false

func _ready():
	randomize()
	mode = MODE_STATIC
	set_frame()
	Global.connect("throwing_last_item", self, "_throwing_last_item")
	
func set_frame():
	get_node("Sprite").frame = randi() % 5 # Set the frame to a random value between 0 and 4

func _process(_delta):
	
	#if isThrown:
	#	if selected: #when selected is true (if draggable item clicked, it's true)
	#		followMouse()
	#	else:
	#		set_collision_layer_bit(7, true) # Dog
	#		set_collision_layer_bit(8, true) # Granny
	#		set_collision_layer_bit(9, true) # Boy
	#		var speed = 180
	#		velocity = Vector2(speed * 2, -speed * 2)
	#else:
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
				
				if isThrown:
					mode = MODE_RIGID; #set to Rigid mode to get the gravity fall.
					
					set_collision_layer_bit(7, true) # Dog
					set_collision_layer_bit(8, true) # Granny
					set_collision_layer_bit(9, true) # Boy
					#var speed = 180
					#velocity = Vector2(speed * 2, -speed * 2)
				else:
					selected = true #it is selected/picked
					mode = MODE_RIGID; #set to Rigid mode to get the gravity fall.
					set_collision_layer_bit(6, true) #let it detect the cart now that it's picked
					$Area2D.set_collision_layer_bit(12, true) #let it detect the player's mouth now that it's picked
			
			else:
				selected = false
					

func _throwing_last_item():
	isThrown = true





