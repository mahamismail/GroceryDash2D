class_name Dog
extends Enemy

export var speed = 180
onready var player = get_node("../../Player")
onready var wall1 = get_node("../../Walls/Wall1")
onready var wall2 = get_node("../../Walls/Wall2")

func _ready():
	velocity.x = -speed

# DOG MECHANIC: Boy makes player dizzy, Dog changes directions when hit with item
func _on_Area2D_body_entered(body):
	
	if body == player:
		print("Dog made you dizzy!")
		Global.emit_signal("lose_health", 1)
		Global.emit_signal("make_dizzy")
		
		# Player hurt audio
		body.get_node("AudioStreamPlayer2D").play()
		yield(get_tree().create_timer(1.0), "timeout")  #struggling with stopping the loop, so settled with stopping it with timer
		body.get_node("AudioStreamPlayer2D").stop()
	
		
	elif body is Projectiles: #if attack area of dog encounters projectile item's area
		var item_node = get_node(body.get_path()) #Geting the node
		var item_sprite = item_node.get_node("Sprite") #Getting the sprite
		var frame = item_sprite.frame
		 
		Global.emit_signal("lose_money", Global.cost[frame]) #getting the cost list from global acc to frame
		velocity.x = speed
		$Sprite.scale.x = -0.76
		#var area2dCollision = body.get_node("Area2D/CollisionShape2D2")
		#area2dCollision.set_deferred("disabled", true)
		body.queue_free()
	
	#Attemp to switch direction when encountering walls
	elif body == wall1.get_node("CollisionShape2D") or body == wall1.get_node("CollisionShape2D2"): 
		velocity.x = -velocity.x
		print("collided with the wall")
		
	elif body == wall2.get_node("CollisionShape2D") or body == wall2.get_node("CollisionShape2D2"):
		velocity.x = -velocity.x
		print("collided with the wall")
		
	# dog bark audio
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(0.8), "timeout")
	$AudioStreamPlayer2D.stop()
	
	

		
