extends Panel

#var health = 3
var health = Global.health
onready var health_label = $Amount
onready var player = get_node("../../Player")



func _ready():
	Global.connect("lose_health", self, "_lose_health")
	
func _lose_health(health_bar: ProgressBar):
	# When player collides with enemy, this function is called.
	health_bar.value -= 0.1 # decrease the progress bar by 10% of the max value

	if health <= 0: #if health is 0 or less, you die. 
		emit_signal("you_Died")
		pass
		
