#SOURCE: https://www.youtube.com/watch?v=rdUgf6r7w2Q "Resource Based Inventory - Godot 3.2 Intermediate Tutorial by HeartBeast"

extends Resource
class_name Inventory

signal items_changed(indexes)

#Creating array to store items picked
export(Array, Resource) var items = [
	null, null, null, null, null, null, null
]

#If item is or is not present already, new item can be placed.
func set_item(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previousItem

#Take out an item from the inventory and place it in the game world
func remove_items(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem

#Add this item to the inventory
###### currently only adding once. Seems like the same items are not being recognized as the same.
func add_item(item):
	var item_added = false
	for i in range(len(items)):
		if items[i] != null:
			if items[i].name == item.name:
				items[i].amount += 1 #adding to the amount
				item_added = true
				var item_index = i
				emit_signal("items_changed", [item_index])
				
				print("item added again!")
				print(items[i].amount)
				
				break
	if item_added == false:
		for i in range(len(items)):
			if items[i] == null:
				set_item(i, item)
				item_added = true
				
				print("item added!")
				
				return true
				break
	

