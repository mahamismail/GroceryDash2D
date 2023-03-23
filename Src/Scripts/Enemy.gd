class_name Enemy 
extends KinematicBody2D
	
const SPEED = 100 #Base Speed
const GRAVITY = 3000

var velocity = Vector2(-SPEED, 0) #Initializing a velocity vector to move the enemy to the left.

func _physics_process(delta):
	# Applying gravity to the velocity vector to make the enemy fall downward
	velocity.y += GRAVITY * delta
	
	# Moving the enemy along the modified velocity vector, and also applying collision detection and response
	move_and_slide(velocity)
