extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Stages/Stage1.tscn")

func _on_exit_pressed():
	get_tree().quit()
