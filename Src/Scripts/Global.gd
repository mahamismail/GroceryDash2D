extends Node

#add all signal emitions right here
signal item_entered_cart(item)
signal you_died()
signal lose_money(lost_amount)
signal lose_health(lost_amount)
signal gain_health(gain_amount)
signal make_dizzy()
signal start_floating()
signal throwing_last_item()

var health = 20
var money = 200
var cost = [8, 3, 2, 5, 10]



