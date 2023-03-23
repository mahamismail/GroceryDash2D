extends HBoxContainer

onready var itemTextureRect = $ItemTextureRect
onready var itemLabel = $ItemLabel
var inventory = preload("res://Src/UserInterface/Inventory/Inventory.tres")

#func _ready():
#	inventory.connect("item_entered_cart", self, "display_item")
#	pass

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
		itemLabel.text = str(item.amount) 
	else:
		itemTextureRect.texture = load("res://Assets/Draggables/chips.png")
		itemLabel.text = str(item.amount) 

func _item_entered_cart(item):
	inventory.add_item(item)
