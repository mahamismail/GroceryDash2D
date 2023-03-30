extends Area2D

onready var player = get_node("../../Player") #get Player
#onready var position2D = get_node("../../Position2D")#get Position2D node

export(NodePath) var target_position: NodePath
export var label_text: String = "1"

func _ready():
	 # Set the text of the label to the exported label_text when clicked
	$Label.text = label_text

func _on_Isle_Entry_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			# Set the player's position to the new position when clicked
			var target_position_node = get_node(target_position)
			player.position = target_position_node.position

