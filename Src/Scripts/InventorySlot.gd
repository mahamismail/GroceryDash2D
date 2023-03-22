extends HBoxContainer

onready var itemTextureRect = $ItemTextureRect
var inventory = preload("res://Src/UserInterface/Inventory.tres")

func _ready():
	#inventory.connect("item_entered_cart", self, "_item_entered_cart")
	pass

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Assets/Draggables/chips.png")

func _item_entered_cart(item):
	inventory.add_item(item)
