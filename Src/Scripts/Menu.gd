extends Control

onready var root = get_tree().get_root() # root of scene tree is retrieved & assigned to `root` variable.
onready var scene_root = root.get_child(root.get_child_count() - 1); # scene root is also retrieved & assigned to `scene_root` variable.

func _on_play_pressed(): #PLAY BUTTON goes to Game Screen
	get_tree().change_scene("res://Src/Scenes/Gameplay.tscn");

func _on_instructions_pressed(): # HOW TO PLAY BUTTON goes to Intro & Instructions Screen
	get_tree().change_scene("res://Src/Scenes/InstructionPage.tscn");

func _on_quit_pressed(): # QUIT BUTTON quits the game
	scene_root.notification(NOTIFICATION_WM_QUIT_REQUEST)
	get_tree().quit()

func _on_backtomenu_pressed(): #BACK TO MENU BUTTON takes you back to Title Page
	get_tree().change_scene("res://Src/Scenes/TitlePage.tscn");
