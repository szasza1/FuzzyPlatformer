extends CharacterBody3D

@onready var globals = get_node("/root/Globals")

@export var speed:int = 7
@export var health:float = 5
@export var damage:float = 1


func _physics_process(delta):
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("ammo"):
			health -= 1
			var ammo = collision.get_collider()
			ammo.delete()
		
		if health <= 0:
			hide()
			queue_free()
			globals.add_score(1)
	
	move_and_slide()


func death() -> bool:
	if health <= 0:
		hide()
		queue_free()
		return true

	return false
