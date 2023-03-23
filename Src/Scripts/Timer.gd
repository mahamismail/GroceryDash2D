extends Node2D

# define the duration of the timer in seconds
const TIMER_DURATION = 120

# declare variables to store the timer value and the UI label node
var timer_value = TIMER_DURATION
var timer_label

# called when the game scene is initialized
func _ready():
	# get a reference to the UI label node
	timer_label = get_node("TimerLabel")
	# start the timer countdown
	start_timer()

# function to start the timer countdown
func start_timer():
	# call the _process() function every frame
	set_process(true)

# function called every frame
func _process(delta):
	# decrement the timer value by delta (the time since the last frame)
	timer_value -= delta
	# update the UI label text to display the timer value in minutes and seconds format (00:00)
	var minutes = int(timer_value / 60)
	var seconds = int(timer_value) % 60
	timer_label.text = str(minutes) + ":" + str(seconds)
	if timer_value <= 0:
		stop_game()

# function to stop the game when the timer runs out
func stop_game():
	# stop calling the _process() function every frame
	set_process(false)
	get_tree().change_scene("res://Src/Scenes/LosePage.tscn"); 
