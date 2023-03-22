#SOURCE: https://www.youtube.com/watch?v=rdUgf6r7w2Q "Resource Based Inventory - Godot 3.2 Intermediate Tutorial by HeartBeast"

extends Resource
class_name Inventory

signal items_changed(indexes)
export(Array, Resource) var items = [
	null, null, null, null, null, null, null
]

func set_item(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previousItem

func remove_items(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem

func add_item(item):
	var item_added = false
	for i in range(len(items)):
		if items[i] != null:
			if items[i].name == item.name:
				items[i].amount += 1
				item_added = true
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
	

