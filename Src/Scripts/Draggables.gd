extends RigidBody2D

var item
var inventory = preload("res://Src/UserInterface/Inventory.tres")

var selected = false
var velocity = get_linear_velocity()
onready var collision_shape = $CollisionBody
onready var sprite = $Sprite

func _ready():
	sprite.texture = item.texture

func _process(_delta):
	if selected:
		followMouse()
	else:
		velocity = Vector2(0,0)

func followMouse():
	position = get_global_mouse_position()
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
			if event.pressed:
				selected = true
				mode = MODE_RIGID;
				set_collision_layer_bit(6, true)
			else:
				selected = false
					
#stop the item from rotating wildly.
func _integrate_forces(_state):
	self.rotation_degrees = 0


