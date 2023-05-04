extends CharacterBody3D

@onready var player_globals = get_node("/root/Globals")

@export var speed:int = 4
@export var health:float = 5
@export var damage:float = 1


@onready var viewArea:Area3D = $ViewArea

func _physics_process(delta):
	var player_pos = _check_player()
	if player_pos != Vector3.ZERO:
		look_at(player_pos, Vector3.UP)
		
		#var direction:Vector3 = (viewArea.transform.basis * Vector3(input_dir.x , 0, input_dir.y)).normalized()
		
		velocity = Vector3.FORWARD * speed
		velocity = velocity.rotated(Vector3.UP, rotation.y)
	move_and_slide()
	
func _check_player() -> Vector3:
	for node in viewArea.get_overlapping_bodies():
		if node.is_in_group("player"):
			return node.position
	return Vector3.ZERO
