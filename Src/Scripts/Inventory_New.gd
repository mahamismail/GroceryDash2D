extends HBoxContainer

# Define the maximum number of items that can be stored in the inventory
var base_item = load("res://Src/Objects/Base_Item_Redo.tscn")
var item_counts = {} # Dictionary to store the number of items per frame index
var item_sprites = {} # Dictionary to store the sprites of items per frame index
var inventory_slot = load("res://Src/UserInterface/Inventory/InventorySlot.tscn")


func _ready():
	Global.connect("item_entered_cart", self, "add_item")

func add_item(item):
	# Get the frame of the item instance
	var frame
	
	if item.has_node("Sprite"):
		# If the item has a Sprite node, get the frame from it
		frame = item.get_node("Sprite").frame
	else:
		# If the item doesn't have a Sprite node, exit the function
		return
		
	# Check if the item_counts dictionary has an entry for this frame
	if not item_sprites.has(frame):
		
		item_counts[frame] = 1 # If frame isn't present, initialize it with a count of 1
		var inv_slot_instance = inventory_slot.instance() #make an instance of inventory_slot scene.
		print ("something happens")
		item_sprites[frame] = inv_slot_instance.get_node("Sprite") # put sprite node in the sprite dictionary
		item_sprites[frame].texture = item.get_node("Sprite").texture # add the item's texture
		item_sprites[frame].scale = Vector2(0.5, 0.5)
		item_sprites[frame].frame = frame # add the frame number

		var inv_item_label = inv_slot_instance.get_node("Label") #Get the label
		inv_item_label.text = str(item_counts[frame]) #Update the label
		add_child(inv_slot_instance)
		print ("item added to inventory")
			
	elif item_sprites.has(frame):
		# If it does, increment the count by 1
		item_counts[frame] += 1
		var inv_slot_instance = inventory_slot.instance()
		var inv_item_label = inv_slot_instance.get_node("Label")
		inv_item_label.text = str(item_counts[frame])
	# Add the item to the inventory
	# ...
