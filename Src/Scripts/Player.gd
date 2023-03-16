extends KinematicBody2D

var velocity = Vector2(0,-1)
const SPEED = 180;
const GRAVITY = 3000;
const JUMP_FORCE = -900;

func _physics_process(_delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED;
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED;
	
	velocity.y = velocity.y + 30

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE;
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x , 0 , 0.2)
