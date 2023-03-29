extends Panel

var health = Global.health
#onready var player = get_node("../../Player")

func _ready():
	$HealthBar.value = health
	Global.connect("lose_health", self, "_lose_health")
	Global.connect("gain_health", self, "_gain_health")
	
func _lose_health(lost_amount):
	health = health - 1 # decrease the progress bar by 10% of the max value
	$HealthBar.value = health
	print("losing health")
	
	if health <= 0: #if health is 0 or less, you die. 
		Global.emit_signal("you_died")
		pass
		
func _gain_health(gain_amount):
	health = health + gain_amount # decrease the progress bar by 10% of the max value
	$HealthBar.value = health
	print("losing health")
	
	if health <= 0: #if health is 0 or less, you die. 
		Global.emit_signal("you_died")
		pass
		
