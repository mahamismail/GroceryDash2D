class_name Dog
extends Enemy

export var speed = 180
onready var player = get_node("../Player")

func _ready():
	velocity.x = -speed

func _on_Area2D_body_entered(body):
	if body == player:
		print("Dog made you dizzy!")
		Global.emit_signal("lose_health", 1)
		Global.emit_signal("make_dizzy")
	
	elif body is Projectiles:
		var item_node = get_node(body.get_path()) #Geting the node
		var item_sprite = item_node.get_node("Sprite") #Getting the sprite
		var frame = item_sprite.frame
		 
		Global.emit_signal("lose_money", Global.cost[frame])
		
		queue_free()
		body.queue_free()

		
