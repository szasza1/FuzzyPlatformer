extends RigidBody3D

@export var force = 1000
var spawn_position:Vector3


func _ready():
	set_global_position(spawn_position)


func initialize(forward_vector:Vector3, spawn_pos:Vector3) -> void:
	spawn_position = spawn_pos
	add_constant_force(forward_vector * force)


func _on_timer_timeout():
	queue_free()
