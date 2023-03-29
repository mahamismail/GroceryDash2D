class_name Boy
extends Enemy

export var speed = 150

func _ready():
	velocity.x = -speed

func _on_AttackArea_body_entered(body):
	if not body is Enemy:
		print("Boy stole money!")
		Global.emit_signal("lose_money", 25)
		Global.emit_signal("lose_health", 1)
