extends Panel

#var health = 3
var health = Global.health
onready var health_label = $Amount
onready var player = get_node("../../Player")

signal you_Died()

func _ready():
		player.connect("lose_health", self, "_lose_health")
	
func _lose_health(): #When player collides with enemy, this function is called.
	health = health - 1
	health_label.set_text(str(health))
	print(health)
	
	if health <= 0: #if health is 0 or less, you die. 
		emit_signal("you_Died")
		pass
