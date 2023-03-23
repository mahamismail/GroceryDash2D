extends HBoxContainer

var inventory = preload("res://Src/UserInterface/Inventory/Inventory.tres")

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")

# Updates the display of all inventory slots (each child node of this node)
func update_inventory_display():
	#Looping over all the items in the inventory object
	for item_index in inventory.items: #.size() (?)
		update_inventory_slot_display(item_index)

#Updates the display of a particular inventory slot
func update_inventory_slot_display(item_index):
	#getting child node at the specified index
	var inventorySlotDisplay = get_child(item_index)
	# Getting item at the specified index in the inventory object
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)

#Called when the "items_changed" signal is emitted. "indexes" contains the indexes of the items that were changed
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)
