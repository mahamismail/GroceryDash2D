extends HBoxContainer

onready var itemTextureRect = $ItemTextureRect
onready var itemLabel = $ItemLabel
var inventory = preload("res://Src/UserInterface/Inventory/Inventory.tres")
#onready var cart = get_node("../../../../Player/Cart")
onready var cart = load("res://Src/Actors/Cart.tscn")

func _ready():
	#ERROR: wanted to get the item that enters the cart, 
	#and then use inventory based functions to add the item to the Slot. 
	#But none of my code created signals work.
	#cart.connect("item_entered_cart", self, "_item_entered_cart")
	pass

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
		itemLabel.text = str(item.amount) 
	else:
		itemTextureRect.texture = load("res://Assets/Draggables/chips.png")
		itemLabel.text = str(item.amount) 

func _item_entered_cart(item):
	inventory.add_item(item)
	display_item(item)
