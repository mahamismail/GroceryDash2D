extends Node

#add all signal emitions right here
signal item_entered_cart(item)
signal you_died()
signal you_win()
signal lose_money(lost_amount)
signal lose_health(lost_amount)
signal gain_health(gain_amount)
signal make_dizzy()
signal start_floating()
signal throwing_last_item()

var health = 20
var money = 200
var cost = [8, 3, 2, 5, 10, 8, 3, 2, 5, 10]
var frame_ofLastPicked
var level = 0

var items_Required = []
class itemReqObj:
	var frame
	var quantity

var is_paused = false

func _input(event):
	if event.is_action_pressed("pause"):
		is_paused = !is_paused
		set_pause(is_paused)

func set_pause(pause):
	if pause == true:
		get_tree().paused = true
		# Call any custom pause function here
	else:
		get_tree().paused = false
		# Call any custom unpause function here
	
