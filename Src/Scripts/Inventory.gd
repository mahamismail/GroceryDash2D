extends HBoxContainer

const SlotClass = preload("res://Src/Scripts/Slot.gd")
# Define the maximum number of items that can be stored in the inventory
var base_item = load("res://Src/Objects/Base_Item_Redo.tscn")
var inventory_slot = load("res://Src/UserInterface/Inventory/InventorySlot.tscn")

var frame_ofLastPicked = Global.frame_ofLastPicked

var itemList = []
var allItemsFound = false

func _ready():
	Global.connect("item_entered_cart", self, "add_item") #connecting signal from Global
	Global.connect("throwing_last_item", self, "remove_thrown_item") #connecting signal from Global
	
func add_item(item):
	var frame # Variable to store the frame of the item instance
	frame = item.get_node("Sprite").frame # get the frame from it
	
	if not itemList.has(frame):
		itemList.append(frame) # add to list
		
		var inv_slot_instance = inventory_slot.instance() #make an instance of inventory_slot scene.
		
		var sprite = inv_slot_instance.get_node("Sprite") # put sprite node in the sprite dictionary
		sprite.texture = item.get_node("Sprite").texture # add the item's texture
		sprite.scale = Vector2(1, 1)
		sprite.frame = frame
		
		var label = inv_slot_instance.get_node("Label") #get the label.
		label.text = str(1) + "x" #add 1 amount to the item.
		
		add_child(inv_slot_instance) #add this child to the HBoxContainer
		Global.frame_ofLastPicked = frame

	elif itemList.has(frame):
		
		for inv_slot_instance in self.get_children(): #go through all the children of HBoxContainer
			var sprite = inv_slot_instance.get_node("Sprite") #get the sprite of the child slot
			if sprite != null and sprite.frame == frame: #check if the frame is the same of any of these slots
				var label = inv_slot_instance.get_node("Label") # get the label of the slot
				var amount = int(label.text)
				amount = amount + 1 # add 1 more amount
				label.text = str(amount) + "x" # put it in the label
				
				Global.frame_ofLastPicked = frame
	
	#TO WIN BY COLLECTING 8 CHEESE (frame 2)
	#for inv_slot_instance in self.get_children(): #go through all the children of HBoxContainer
	#		var sprite = inv_slot_instance.get_node("Sprite") #get the sprite of the child slot
	#		if sprite != null and sprite.frame == 1: #check if the frame is the same of any of these slots
	#			var label = inv_slot_instance.get_node("Label") # get the label of the slot
	#			if label.text == str(8): # put it in the label
	#				Global.emit_signal("you_win")
	
	checkAllItemsFound(itemList, Global.items_Required)
	
	if allItemsFound == true:
		Global.emit_signal("you_win")


func checkAllItemsFound(itemList: Array, items_Required: Array) -> bool:

	var counter = 0
	var allitemsPresent = false
	
	for item in items_Required: # check all the items in the items_Required list
		
		var itemFrame = item.frame #get the item's frame property
		
		if not itemList.find(itemFrame) >= 0: # start  
			allItemsFound = false
			break
			
		else:
			for inv_slot_instance in self.get_children(): #go through all the children of HBoxContainer
				var label = inv_slot_instance.get_node("Label") # get the label of the slot
				if label.text != item.quantity: 
					allItemsFound = false
					break
				else:
					counter += 1
					if counter == len(items_Required):
						print("Task completed")
						allItemsFound = true
	
	return allItemsFound


func remove_thrown_item():
	var frame # Variable to store the frame of the item instance
	frame = Global.frame_ofLastPicked # get the frame from it

	for inv_slot_instance in self.get_children(): #go through all the children of HBoxContainer
		var sprite = inv_slot_instance.get_node("Sprite") #get the sprite of the child slot
		if sprite != null and sprite.frame == frame: #check if the frame is the same of any of these slots
			var label = inv_slot_instance.get_node("Label") # get the label of the slot
			var amount = int(label.text)
			amount = amount - 1 # add 1 more amount
			label.text = str(amount) # put it in the label
			
			Global.frame_ofLastPicked = frame
	
	print(itemList)
