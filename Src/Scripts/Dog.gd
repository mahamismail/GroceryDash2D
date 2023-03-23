class_name Dog
extends Enemy

export var speed = 180

func _ready():
	velocity.x = -speed


func _on_Area2D_body_entered(body):
	print("Dog hit Player!")
	
