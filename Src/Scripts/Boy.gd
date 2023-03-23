class_name Boy
extends Enemy

export var speed = 150

func _ready():
	velocity.x = -speed

func _on_AttackArea_body_entered(body):
	print("Boy stole from Player!")
