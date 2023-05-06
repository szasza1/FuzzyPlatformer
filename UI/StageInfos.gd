extends Control

@onready var globals = get_node("/root/Globals")

@onready var score := $Infos/CollectedScore
@onready var time := $Infos/Time

func _ready():
	score.text = "Collected score: %d" % globals.score
	time.text = "Time: %.3f" % globals.spent_time
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_next_level_pressed():
	var stage_path: String = ""
	if globals.has_next_level():
		stage_path = "res://Stages/Stage%d.tscn" % globals.current_level
	else:
		stage_path = "res://UI/Menu.tscn"
		
	get_tree().change_scene_to_file(stage_path)
