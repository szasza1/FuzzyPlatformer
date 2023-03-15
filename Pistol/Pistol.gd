extends Node3D

@export var ammo_scene:PackedScene

@onready var shot_point := $ShotPoint
@onready var stage = get_node("/root/Main/Stage")


func action():
	var ammo = ammo_scene.instantiate()
	var shot_global_position = shot_point.get_global_position()
	var shot_direction = -(shot_point.get_global_transform().basis.z)
	
	ammo.initialize(shot_direction, shot_global_position)
	stage.add_child(ammo)
