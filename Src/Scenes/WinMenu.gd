extends Control

onready var playAgainButton = $ColorRect/VBoxContainer2/PlayAgain
onready var root = get_tree().get_root() # root of scene tree is retrieved & assigned to `root` variable.
onready var scene_root = root.get_child(root.get_child_count() - 1); # scene root is also retrieved & assigned to `scene_root` variable.

func _ready():
	if Global.level == 3:
		playAgainButton.queue_free()
	elif Global.level < 3:
		playAgainButton.get_node("Label").text = "Next Level"

func _on_quit_pressed(): # QUIT BUTTON quits the game
	scene_root.notification(NOTIFICATION_WM_QUIT_REQUEST)
	get_tree().quit()

func _on_backtomenu_pressed(): #BACK TO MENU BUTTON takes you back to Title Page
	Global.level = 1
	get_tree().change_scene("res://Src/Scenes/TitlePage.tscn");

func _on_PopUpfirst_pressed():
	get_tree().change_scene("res://Src/Scenes/PopUp.tscn");

