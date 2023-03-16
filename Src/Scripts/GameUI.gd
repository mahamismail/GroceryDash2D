extends Control

var time_left = 60  # set the initial time here, in seconds

onready var timer = $Timer

func _ready():
	timer.start()

func _on_Timer_timeout():
	time_left -= 1
	update_timer()

func update_timer():
	$Label.text = "Time left: " + str(time_left) + " seconds"

# add other methods for handling game over, resetting the timer, etc.
