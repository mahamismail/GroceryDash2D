# Declare a new class called "Enemy" that extends KinematicBody2D
class_name Enemy 
extends KinematicBody2D
	
const SPEED = 100 #I would like this to be a unique varible
const GRAVITY = 3000

var velocity = Vector2(-SPEED, 0) #Initializing a velocity vector to move the enemy to the left.

# Define a function that is called every frame to update the position of the enemy
func _physics_process(delta):
	# Apply gravity to the velocity vector to make the enemy fall downward
	velocity.y += GRAVITY * delta
	
	# Move the enemy along the modified velocity vector, and also apply collision detection and response
	move_and_slide(velocity)
