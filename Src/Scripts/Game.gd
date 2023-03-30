extends Node2D

onready var MetalMusic = get_node("InterfaceLayer/Music/HSlider/AudioStreamPlayer")
onready var granny = get_node("Granny")
onready var grannyTimer = get_node("Granny/GrannyTimer")
onready var player = get_node("Player")
var full = preload("res://Assets/Draggables/empty.png")

var timer = null #for Grandma
var damageTimer = null #For Player

var base_item = load("res://Src/Objects/Base_Item_Redo.tscn")
onready var all_item_children = get_node("Draggables_trials")


func _ready():
	pass
	
#Changing the volume of music in headphones
func _on_HSlider_value_changed(value):
	print("music volume changed")
	MetalMusic.volume_db = lerp(-76, -72, value) #setting audible and scrollable values of the music

	# checking the required volume to avoid Grandma
	if value <= 20 and value > 16:
		#setting a timer to keep volume consistent for 5 seconds
		if timer != null:  # if there is an active timer, stop it and remove it
			timer.stop()
			remove_child(timer)
			timer = null

		timer = Timer.new()
		timer.set_wait_time(5.0)  # setting the delay to 5 seconds
		timer.set_one_shot(true)  # making the timer fire only once
		timer.connect("timeout", self, "_on_granny_collision_mask_timeout")
		add_child(timer)
		timer.start()

		#Linking this timer to a progress bar called timer on top of Granny to know when 5 seconds are up
		grannyTimer.value = 0 #Setting the initial value of the progress bar to 0
		grannyTimer.max_value = timer.wait_time # Setting the max_value of the progress bar to the timer's wait_time
	
		grannyTimer.show()#Show the progress bar when the timer starts
	
	#if the this is not the required volume to avoid Grandma
	else:
		#If timer is active, stop it and remove it.
		if timer != null: 
			timer.stop()
			remove_child(timer)
			timer = null
			
		# Hide the progress bar when the timer stops
		grannyTimer.hide()
	
	# Now if the value is greater than or equal to 15, 
	#wait until 5 seconds, then start damaging the player's health
	if value >= 16:
		if damageTimer == null:
			damageTimer = Timer.new()
			damageTimer.set_wait_time(5.0)
			damageTimer.set_one_shot(false)
			damageTimer.connect("timeout", self, "_on_damage_timer_timeout")
			add_child(damageTimer)
			damageTimer.start()
			Global.emit_signal("lose_health", 0.5)
	else:
		if damageTimer != null:
			damageTimer.stop()
			remove_child(damageTimer)
			damageTimer = null
	
#When the timer times out
func _on_granny_collision_mask_timeout():
	granny.set_collision_layer_bit(0, false)
	granny.is_colliding = false
	
	grannyTimer.hide() #Hide the progress bar when the timer times out
	grannyTimer.value += 1 #Update the value of the progress bar each time the timer fires
	
func _on_damage_timer_timeout():
	# Reduce the player's health after 5 seconds
	Global.emit_signal("lose_health", 0.5);
	print("Lost health")

	if damageTimer != null and damageTimer.is_stopped() == false:
		damageTimer.start()
