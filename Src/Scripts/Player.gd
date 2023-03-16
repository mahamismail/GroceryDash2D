extends KinematicBody2D


onready var game_Path = get_node(@"../../")

var velocity = Vector2(0,-1)
const SPEED = 180;
const GRAVITY = 3000;
const JUMP_FORCE = -900;

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

# Function called when the Area2D body enters a collision
func _on_Area2D_body_entered(body):
	# Check if the colliding body is an Enemy
	if body is Enemy:
		# Print message and end game
		print("Enemy attacked")
		queue_free();
