extends Control

onready var itemsRequiredList = $ColorRect/itemsRequiredList
onready var taskLabel = $ColorRect/Task
var base_item = load("res://Src/Objects/Base_Item_Redo.tscn")
var inventory_slot = load("res://Src/UserInterface/Inventory/InventorySlot.tscn")
var sprite_texture = load("res://Assets/Draggables/New folder/pixel_food.png")

var level = Global.level


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.level = level + 1 #moves to the new level
	level = Global.level
	
	taskLabel.text = "Task " + str(level) #Task label
	
	if level == 1:
		add_item()
	elif level == 2:
		add_item()
		add_item()
	elif level == 3:
		add_item()
		add_item()
		add_item()
		add_item()
	pass # Replace with function body.

func _on_play_pressed(): #PLAY BUTTON goes to Game Screen
	get_tree().change_scene("res://Src/Scenes/Gameplay.tscn");

func _on_backtomenu_pressed(): #BACK TO MENU BUTTON takes you back to Title Page
	get_tree().change_scene("res://Src/Scenes/TitlePage.tscn");

func add_item():
	randomize()
	
	var itemObj = Global.itemReqObj.new() #create a new object that will be added to the Global items_Required array
	var frame
	var quantity = 0
	var max_per_item
	var min_per_item
	
	if level == 1:
		max_per_item = 8 #maximum quantity possible for each item
		min_per_item = 5
		frame = randi() % 11 # randomize the frame number for random item
	if level == 2:
		max_per_item = 5 #maximum quantity possible for each item
		min_per_item = 0
		frame = randi() % 11 # randomize the frame number for random item
	else:
		max_per_item = 5 #maximum quantity possible for each item
		min_per_item = 0
		frame = randi() % 11 # randomize the frame number for random item
	
	# CODE TO ADD A RANDOM ITEM AS AN INVENTORY SLOT SCENE TO THE HBOXCONTAINER
	
	frame = randi() % 11 # randomize the frame number for random item
	
	if not Global.items_Required.has(frame): #if this item isn't already added in the Required List then go inside
		
		#Creating & customizing the item slot instance
		var inv_slot_instance = inventory_slot.instance() # create an instance of inventory_slot scene.
		#Sprite
		var sprite = inv_slot_instance.get_node("Sprite") # get the sprite node of the scene
		sprite.texture = sprite_texture # add the png as its texture
		sprite.scale = Vector2(1, 1) # set its scale
		sprite.frame = frame # set it's frame to the randomized frame
		#Label
		var label = inv_slot_instance.get_node("Label") #get the label from the slot node.

		while quantity <= min_per_item: #ERROR: this should limit the minimum range of the quantity but it still doesn't work
			quantity = randi() % max_per_item
		
		label.text = str(quantity) + "x" #add the number to the label as a string
		
		itemsRequiredList.add_child(inv_slot_instance) # also add this child to the HBoxContainer
		
		#CODE TO APPEND FRAME AND QUANTITY PROPERTIES TO THE OBJECT IN THE GLOBAL items_Required LIST
		
		itemObj.frame = frame # add frame
		itemObj.quantity = str(quantity) + "x" # add quantity

		Global.items_Required.append(itemObj) # append the object to the items_Required list
		

	elif Global.items_Required.has(frame): #if this item is already added in the Required List
		add_item() # just start all over again until you find an item that's not already added
