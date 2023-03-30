extends KinematicBody2D

onready var Wall2 = get_node(@"/root/Main/Walls/Wall2")
#VARS FOR CART ENTRY
onready var cartArea = $CartArea #path for Cart

#VARS FOR DIZZY SLIDERS
onready var dizzySlider1 = get_node("../InterfaceLayer/DizzySliders/HSlider") #getting path for top slider 
onready var dizzySlider2 = get_node("../InterfaceLayer/DizzySliders/HSlider2") #getting path for bottom slider
onready var dizzyView = get_node("../InterfaceLayer/DizzyView") # getting the red rect
onready var dizzySliders = get_node("../InterfaceLayer/DizzySliders") #getting the sliders panel
var randomNum = rand_range(0, 10) #generating a random number
var dizzySlider2_value # value of bottom slider
var dizzySlider1_value # value of top slider
var isSliderCorrect = false # Top Slider's value is correct
var isSlider2Correct = false #Bottom Slider's  value is correct
export var isDizzy = false # Player is not dizzy right now

#VAR FOR FLOATING FROM EATING CHOCOLATE 
export var isFloating = false # Player is not floating right now

#VAR FOR THROWING ITEMS AT OBSTACLES
onready var projectile = preload("res://Src/Objects/Projectile_Item.tscn") #grocery item as a projectile
var isThrowing = false 
const THROW_FORCE = 500 # the force item can be thrown at

#VAR FOR PLAYER MOVEMENT
var velocity = Vector2(0,-1)
const SPEED = 180;
const GRAVITY = 3000;
const JUMP_FORCE = -900;
	
func _ready():
	Global.connect("you_died", self, "_you_died")
	Global.connect("make_dizzy", self, "make_dizzy")
	Global.connect("you_win", self, "_you_win") #connecting signal from Global
	
	dizzySlider2_value = rand_range(0, 10) #assigning a random range so the dizzy sliders have different values to find each time
	dizzySlider1_value = rand_range(0, 10) #assigning a random range so the dizzy sliders have different values to find each time

	
func _physics_process(_delta):
	
	if isDizzy: #if player is dizzy
		var speed = 50 # make speed slower than usual
		var jump_force = -400; # make jump force slower than usual
		# Check input for horizontal movement
		if Input.is_action_pressed("move_right"):
			velocity.x = speed;
		if Input.is_action_pressed("move_left"):
			velocity.x = -speed;

		# Apply gravity
		velocity.y = velocity.y + 30

		# Check input for jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force

	elif isFloating: #if player is floating
		# Check input for horizontal movement
		if Input.is_action_pressed("move_right"):
			velocity.x = SPEED;
		if Input.is_action_pressed("move_left"):
			velocity.x = -SPEED;

		# Don't apply gravity
		velocity.y = 0 # make y velocity non existent

	else:
		# Check input for horizontal movement
		if Input.is_action_pressed("move_right"):
			velocity.x = SPEED;
		if Input.is_action_pressed("move_left"):
			velocity.x = -SPEED;

		# Apply gravity
		velocity.y = velocity.y + 30

		# Check input for jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_FORCE;

		# Check input for throwing
		if Input.is_action_just_pressed("throw") and !isThrowing:
			if Global.frame_ofLastPicked != null:
				Global.emit_signal("lose_money", 25)
				Global.emit_signal("throwing_last_item") #connecting to Inventory.gd
				var thrown_projectile = projectile.instance()
				thrown_projectile.translate(position - thrown_projectile.position)
				#thrown_projectile.get_node("Area2D/CollisionShape2D2").disabled
				get_node("/root/Main").add_child(thrown_projectile)
			

	# Move and slide the character
	velocity = move_and_slide(velocity, Vector2.UP)

	# Apply friction to x-velocity
	velocity.x = lerp(velocity.x , 0 , 0.2)
	
# Function called when the player's Area2D body enters a collision
func _on_Area2D_body_entered(body): # Make sure the Area2D of the player extends beyond the Collider2D of the player, else might not get detected.

	# Check if it's the temporary End Wall
	if (body == Wall2):
		get_tree().change_scene("res://Src/Scenes/WinScene.tscn");

func make_dizzy(): #if both the two values of the sliders chosen by the player are correct then make the isDizzy false
	# check if both slider values are correct
	if isSliderCorrect and isSlider2Correct:
		print("not dizzy anymore")
		dizzyView.hide()
		dizzySliders.hide()
		return !isDizzy
	else:
		dizzyView.show()
		dizzySliders.show()
		return isDizzy

func start_floating():
	Global.emit_signal("gain_health", 50)
	# Move the object up by 2 units
	translate(Vector2(0, -200))
	velocity = Vector2(SPEED, -SPEED)
	
	# Move and slide the character
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_MouthArea_area_entered(area):
	var item_node = area.get_parent() #Geting the node
	var item_sprite = item_node.get_node("Sprite") #Getting the sprite
	var frame = item_sprite.frame

	if frame == 4: 
		isFloating = true
		start_floating()
		item_node.queue_free()

func _on_HSlider_value_changed(value):
	if not isSliderCorrect:
		if value == 5: #dizzySlider1_value:
			isSliderCorrect = true
			print("correct slider1")
	make_dizzy()

func _on_HSlider2_value_changed(value):
	if not isSlider2Correct:
		if value == 8: #dizzySlider2_value:
			isSlider2Correct = true
			print("correct slider2")
	make_dizzy()

func _you_died():
	$CollisionShape2D.set_deferred("disabled", true) #disable the collider before health goes into negatives
	queue_free() # make the player invisible.
	get_tree().change_scene("res://Src/Scenes/LosePage.tscn");
	pass # Replace with function body.

func _you_win():
	$CollisionShape2D.set_deferred("disabled", true) #disable the collider before health goes into negatives
	queue_free() # make the player invisible.
	get_tree().change_scene("res://Src/Scenes/WinScene.tscn")
	pass # Replace with function body.
