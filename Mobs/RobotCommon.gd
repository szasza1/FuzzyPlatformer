extends CharacterBody3D

@onready var globals = get_node("/root/Globals")

@export var speed:int = 2
@export var health:float = 5
@export var damage:float = 1
@export var min_fight_distance:float = 1.2

@onready var viewArea:Area3D = $ViewArea
@onready var animation := $Animation

func _physics_process(delta):
	
	if _is_dead(): return
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("ammo"):
			health -= 1
			var ammo = collision.get_collider()
			ammo.delete()
		
		if health <= 0:
			animation.set_current_animation("Death")
			globals.add_score(1)
			
	if _is_dead(): return
	
	var player_pos = _check_player()
	# If the player is in the mob's view area
	if player_pos != Vector3.ZERO:
		# Rotate forward the player
		look_at(player_pos, Vector3.UP)
		# If the player is close enough to fight with
		if global_position.distance_to(player_pos) < min_fight_distance:
			globals.damage(damage * delta)
			animation.set_current_animation("Attack")
		else:
			# Move towards the player
			velocity = Vector3.FORWARD * speed
			velocity = velocity.rotated(Vector3.UP, rotation.y)
			animation.set_current_animation("Walk")

	# If the mob doesn't see the player.
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		animation.set_current_animation("Idle")
	move_and_slide()
	
func _check_player() -> Vector3:
	for node in viewArea.get_overlapping_bodies():
		if node.is_in_group("player"):
			return node.position
	return Vector3.ZERO

func _is_dead() -> bool:
	return health <= 0
	
