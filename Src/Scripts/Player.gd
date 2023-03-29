extends KinematicBody2D

onready var game_Path = get_node(@"../../")
onready var Wall2 = get_node(@"/root/Main/Walls/Wall2")
onready var cartArea = $CartArea

onready var dizzySlider1 = get_node("../InterfaceLayer/DizzySliders/HSlider")
onready var dizzySlider2 = get_node("../InterfaceLayer/DizzySliders/HSlider2")
onready var dizzyView = get_node("../InterfaceLayer/DizzyView")
onready var dizzySliders = get_node("../InterfaceLayer/DizzySliders")
var randomNum = rand_range(0, 10)
var dizzySlider2_value
var dizzySlider1_value

var isSliderCorrect = false
var isSlider2Correct = false

export var isDizzy = false
export var isFloating = false

var velocity = Vector2(0,-1)
const SPEED = 180;
const GRAVITY = 3000;
const JUMP_FORCE = -900;
	
func _ready():
	Global.connect("you_died", self, "_you_died")
	Global.connect("make_dizzy", self, "make_dizzy")
	
	dizzySlider2_value = rand_range(0, 10) #assigning a random range so the dizzy sliders have different values to find each time
	dizzySlider1_value = rand_range(0, 10) #assigning a random range so the dizzy sliders have different values to find each time

	
func _physics_process(_delta):
	
	if isDizzy:
		var speed = 50
		var jump_force = -400;
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
	
	elif isFloating:
		# Check input for horizontal movement
		if Input.is_action_pressed("move_right"):
			velocity.x = SPEED;
		if Input.is_action_pressed("move_left"):
			velocity.x = -SPEED;
		
		# Apply gravity
		velocity.y = 0
	
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

func _you_died():
	$CollisionShape2D.set_deferred("disabled", true) #disable the collider before health goes into negatives
	queue_free() # make the player invisible.
	get_tree().change_scene("res://Src/Scenes/LosePage.tscn");
	pass # Replace with function body.

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
