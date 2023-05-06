extends StaticBody3D

@onready var finArea := $FinishArea
@onready var globals = get_node("/root/Globals")

func _on_finish_area_body_entered(body):
	if body.is_in_group("player"):
		globals.next_level()
		get_tree().change_scene_to_file("res://UI/StageInfos.tscn")

