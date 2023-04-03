class_name Boy
extends Enemy

export var speed = 150
onready var player = get_node("../../Player")

func _ready():
	velocity.x = -speed

func _on_AttackArea_body_entered(body):
	if body == player:
		body.get_node("AudioStreamPlayer2D").play()
		yield(get_tree().create_timer(1.0), "timeout")
		body.get_node("AudioStreamPlayer2D").stop()
		
		print("Boy stole money!")
		Global.emit_signal("lose_money", 25)
		Global.emit_signal("lose_health", 1)
		body.get_node("AnimationPlayer").play("BoySteals")
		
	elif body is Projectiles:
		var item_node = get_node(body.get_path()) #Geting the node
		var item_sprite = item_node.get_node("Sprite") #Getting the sprite
		var frame = item_sprite.frame
		 
		Global.emit_signal("lose_money", Global.cost[frame])
		velocity.x = speed
		$AnimatedSprite.scale.x = -4.719
		
		#var area2dCollision = body.get_node("Area2D/CollisionShape2D2")
		#area2dCollision.set_deferred("disabled", true)
		body.queue_free()
