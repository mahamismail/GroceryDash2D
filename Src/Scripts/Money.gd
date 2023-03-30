extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("lose_money", self, "money_lost")
	$Label.text = str(Global.money) + "$"

func money_lost(cost):
	Global.money = Global.money - cost
	
	if Global.money < 0:
		Global.money = 0;
		
	$Label.text = str(Global.money) + "$"
	
	if Global.money == 0:
		Global.emit_signal("you_died")
