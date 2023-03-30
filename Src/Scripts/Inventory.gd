extends HBoxContainer

const SlotClass = preload("res://Src/Scripts/Slot.gd")
# Define the maximum number of items that can be stored in the inventory
var base_item = load("res://Src/Objects/Base_Item_Redo.tscn")
var inventory_slot = load("res://Src/UserInterface/Inventory/InventorySlot.tscn")

var slotIndex
var slotType

var itemList = []

func _ready():
	Global.connect("item_entered_cart", self, "add_item") #connecting signal from Global
	
func add_item(item):
	var frame # Variable to store the frame of the item instance
	frame = item.get_node("Sprite").frame # get the frame from it
	
	if not itemList.has(frame):
		itemList.append(frame) # add to list
		
		var inv_slot_instance = inventory_slot.instance() #make an instance of inventory_slot scene.
		
		var sprite = inv_slot_instance.get_node("Sprite") # put sprite node in the sprite dictionary
		sprite.texture = item.get_node("Sprite").texture # add the item's texture
		sprite.scale = Vector2(0.5, 0.5)
		sprite.frame = frame
		
		var label = inv_slot_instance.get_node("Label") #get the label.
		label.text = str(1) #add 1 amount to the item.
		
		add_child(inv_slot_instance) #add this child to the HBoxContainer
		
	elif itemList.has(frame):
		
		for inv_slot_instance in self.get_children(): #go through all the children of HBoxContainer
			var sprite = inv_slot_instance.get_node("Sprite") #get the sprite of the child slot
			if sprite != null and sprite.frame == frame: #check if the frame is the same of any of these slots
				var label = inv_slot_instance.get_node("Label") # get the label of the slot
				var amount = int(label.text)
				amount = amount + 1 # add 1 more amount
				label.text = str(amount) # put it in the label
	
	print(itemList)
	pass
	# Check if the item_counts dictionary has an entry for this frame
#	if not item_counts.has(frame):
		
#		item_counts[frame] = 1 # If frame isn't present, initialize it with a count of 1
#		item_sprites[frame] = item.get_node("Sprite")
#		var inv_slot_instance = inventory_slot.instance() #make an instance of inventory_slot scene.
#		print ("something happens")
#		item_sprites[frame] = inv_slot_instance.get_node("Sprite") # put sprite node in the sprite dictionary
#		item_sprites[frame].texture = item.get_node("Sprite").texture # add the item's texture
#		item_sprites[frame].scale = Vector2(0.5, 0.5)
#		item_sprites[frame].frame = frame # add the frame number

#		var inv_item_label = inv_slot_instance.get_node("Label") #Get the label
#		inv_item_label.text = str(item_counts[frame]) #Update the label
#		add_child(inv_slot_instance)
#		print ("item added to inventory")
#			
#	if not item_sprites.has(frame): 
#		print(item_sprites)
#		print(item_counts)
		
#	elif item_sprites.has(frame):
		# If it does, increment the count by 1
#		item_counts[frame] += 1
#		var inv_slot_instance = inventory_slot.instance()
#		var inv_item_label = inv_slot_instance.get_node("Label")
#		inv_item_label.text = str(item_counts[frame])
	
	
