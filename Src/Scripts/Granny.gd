class_name Granny 
extends Enemy

export var speed = 100
onready var player = get_node("../../Player")
var is_colliding = false

func _ready():
	var is_colliding = false

func _physics_process(delta):
	# Making sure the Granny stays unmovable until she is neutralized
	if is_colliding:
		velocity = Vector2.ZERO # Setting velocity to zero if Granny is colliding with another body
	elif not is_colliding :
		velocity.x = -speed # Else keep going at her usual speed
	move_and_slide(velocity)

func _on_AttackArea_body_entered(body):
	if body == player:
		is_colliding = true
		print("Granny stopped you!")	
		$AudioStreamPlayer2D.play()
		
		
		
	elif body is Projectiles:
		var item_node = get_node(body.get_path()) #Geting the node
		var item_sprite = item_node.get_node("Sprite") #Getting the sprite
		var frame = item_sprite.frame
		 
		Global.emit_signal("lose_money", Global.cost[frame])
		
		queue_free()
		body.queue_free()

func _on_AttackArea_body_exited(body):
	is_colliding = false
	$AudioStreamPlayer2D.stop()
