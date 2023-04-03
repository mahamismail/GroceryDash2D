extends Control

onready var playAgainButton = $ColorRect/VBoxContainer2/PlayAgain
onready var root = get_tree().get_root() # root of scene tree is retrieved & assigned to `root` variable.
onready var scene_root = root.get_child(root.get_child_count() - 1); # scene root is also retrieved & assigned to `scene_root` variable.

func _ready():
	Global.items_Required = [] #refresh the array everytime player completes task and comes to this page
	if Global.level == 3:
		playAgainButton.hide() # no option play again if on level 3
	elif Global.level < 3: # can play again if on level 1 or 2
		playAgainButton.show()
		playAgainButton.get_node("Label").text = "Next Level"

func _on_quit_pressed(): # QUIT BUTTON quits the game
	scene_root.notification(NOTIFICATION_WM_QUIT_REQUEST)
	get_tree().quit()

func _on_backtomenu_pressed(): #BACK TO MENU BUTTON takes you back to Title Page
	Global.level = 1
	get_tree().change_scene("res://Src/Scenes/TitlePage.tscn");

func _on_PopUpfirst_pressed():
	get_tree().change_scene("res://Src/Scenes/PopUp.tscn");

