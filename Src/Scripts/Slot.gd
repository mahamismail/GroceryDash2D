extends HBoxContainer

# Define the maximum number of items that can be stored in the inventory
var base_item = load("res://Src/Objects/Base_Item_Redo.tscn")

var inventory_slot = load("res://Src/UserInterface/Inventory/InventorySlot.tscn")
var empty = load("res://Assets/Draggables/empty.png")

var item = null
var slotIndex
var slotType
var slotCount
	
func removeSlot(): #deletes item from slot
	remove_child(item)
	item = null

func pickSlot(): #chooses slot
	remove_child(item)
	var inventoryNode = find_parent("HBoxContainer")
	inventoryNode.add_child(item)
	item = null


