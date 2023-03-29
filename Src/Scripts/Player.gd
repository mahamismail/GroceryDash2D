extends KinematicBody2D

onready var game_Path = get_node(@"../../")
onready var Wall2 = get_node(@"/root/Main/Walls/Wall2")
onready var cartArea = $CartArea

export var isDizzy = false
var velocity = Vector2(0,-1)
const SPEED = 180;
const GRAVITY = 3000;
const JUMP_FORCE = -900;
	
func _ready():
	Global.connect("you_died", self, "_you_died")
	Global.connect("make_dizzy", self, "_make_dizzy")
	isDizzy = false
	
func _physics_process(_delta):
	
	if not isDizzy:
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

	elif isDizzy:
		var speed = 50
		var jump_force = -400;
		# Check input for horizontal movement
		if Input.is_action_pressed("move_right"):
			velocity.x = speed;
		if Input.is_action_pressed("move_left"):
			velocity.x = -speed;
		
		# Apply gravity
		velocity.y = velocity.y + 30
	
		# Check input for jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force
			
	# Move and slide the character
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Apply friction to x-velocity
	velocity.x = lerp(velocity.x , 0 , 0.2)
	
# Function called when the player's Area2D body enters a collision
func _on_Area2D_body_entered(body): # Make sure the Area2D of the player extends beyond the Collider2D of the player, else might not get detected.

	# Check if it's the temporary End Wall
	if (body == Wall2):
		get_tree().change_scene("res://Src/Scenes/WinScene.tscn");
				

func _make_dizzy():
	isDizzy = true;

func _you_died():
	$CollisionShape2D.set_deferred("disabled", true) #disable the collider before health goes into negatives
	queue_free() # make the player invisible.
	get_tree().change_scene("res://Src/Scenes/LosePage.tscn");
	pass # Replace with function body.
