extends HSlider

onready var MetalMusic = $AudioStreamPlayer

func _on_HSlider_value_changed(value):
	MetalMusic.volume_db = lerp(-80, 0, value)
	
	 # Replace with function body.
