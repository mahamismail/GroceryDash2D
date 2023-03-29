class_name Dog
extends Enemy

export var speed = 180



func _ready():
	velocity.x = -speed

func _on_Area2D_body_entered(body):
	if not body is Enemy:
		print("Dog made you dizzy!")
		Global.emit_signal("lose_health", 1)
		Global.emit_signal("make_dizzy")
		
