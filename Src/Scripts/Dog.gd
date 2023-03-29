class_name Dog
extends Enemy

export var speed = 180
onready var dizzyView = get_node("../InterfaceLayer/ColorRect")


func _ready():
	velocity.x = -speed

func _on_Area2D_body_entered(body):
	if not body is Enemy:
		print("Dog made you dizzy!")
		Global.emit_signal("lose_health", 1)
		dizzyView.show()
		Global.emit_signal("make_dizzy")
		
