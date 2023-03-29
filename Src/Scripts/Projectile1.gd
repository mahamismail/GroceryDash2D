class_name Projectiles
extends RigidBody2D
# NOTE: This RigidBodies are set to static mode so the will not move in the beginning

onready var ground = get_node("../Floor")

var selected = false 
var velocity = get_linear_velocity() #getting velocity of the rigidbody
onready var collision_shape = $CollisionBody
onready var sprite = $Sprite

func _ready():
	set_frame()
	#Global.connect("throwing_last_item", self, "_throwing_last_item")
	
func set_frame():
	get_node("Sprite").frame = randi() % 5 # Set the frame to a random value between 0 and 4

