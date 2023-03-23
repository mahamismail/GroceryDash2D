class_name Granny 
extends Enemy

export var speed = 100

var is_colliding = false

func _ready():
	velocity.x = -speed

func _physics_process(delta):
	# Making sure the Granny stays unmovable until she is neutralized
	if is_colliding:
		velocity = Vector2.ZERO # Setting velocity to zero if Granny is colliding with another body
	else:
		velocity.x = -speed # Else keep going at her usual speed
	move_and_slide(velocity)

func _on_AttackArea_body_entered(body):
	is_colliding = true
