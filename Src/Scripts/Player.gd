extends KinematicBody2D

#signal lose_health()

onready var game_Path = get_node(@"../../")
onready var Wall2 = get_node(@"/root/Main/Walls/Wall2")
onready var cartArea = $CartArea

var velocity = Vector2(0,-1)
const SPEED = 180;
const GRAVITY = 3000;
const JUMP_FORCE = -900;
var health = 3
	

func _physics_process(_delta):
	# Check input for horizontal movement
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED;
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED;
	
	# Apply gravity
	velocity.y = velocity.y + 30

	# Check input for jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE;
		
	# Move and slide the character
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Apply friction to x-velocity
	velocity.x = lerp(velocity.x , 0 , 0.2)

# Function called when the player's Area2D body enters a collision
func _on_Area2D_body_entered(body): # Make sure the Area2D of the player extends beyond the Collider2D of the player, else might not get detected.
	
	# Check if the colliding body is an Enemy



	# Check if it's the temporary End Wall
	if (body == Wall2):
		get_tree().change_scene("res://Src/Scenes/WinScene.tscn");
				
		

