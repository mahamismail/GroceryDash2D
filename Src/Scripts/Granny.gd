class_name Granny 
extends Enemy

export var speed = 100

func _ready():
	velocity.x = -speed
	#connect("grandma_move_on", self, "_grandma_move_on")

func _on_AttackArea_body_entered(body):
	print("Granny stopped Player!")
