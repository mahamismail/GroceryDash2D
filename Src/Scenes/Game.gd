extends Node2D

onready var MetalMusic = get_node("InterfaceLayer/Music/HSlider/AudioStreamPlayer")
onready var granny = get_node("Granny")

func _on_HSlider_value_changed(value):
	print("music volume changed")
	MetalMusic.volume_db = lerp(-76, -72, value)

	if value < 20 and value > 16:
		var timer = Timer.new()
		timer.set_wait_time(5.0)  # set the delay to 5 seconds
		timer.set_one_shot(true)  # make the timer fire only once
		timer.connect("timeout", self, "_on_granny_collision_mask_timeout")
		add_child(timer)
		timer.start()
		
func _on_granny_collision_mask_timeout():
	granny.set_collision_mask_bit(0, false)
