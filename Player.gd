extends CharacterBody3D

@onready var player_globals = get_node("/root/Globals")

@export var speed:int = 10
@export var sprint_speed:int = 15
@export var speed_on_wall:int = 20
@export var jump_impulse:int = 10
@export var fall_acceleration:int = 30
@export var fall_acceleration_on_wall:int = 15
@export var can_run_on_wall:bool = false
@export var can_dubble_jump:bool = true

@onready var main_skeleton := $MainSkeleton
@onready var neck := $MainSkeleton/Neck
@onready var hand := $MainSkeleton/Neck/Hand

var first_jump:bool = false

var Pistol = load("res://Pistol/Pistol.tscn")
var pistol:Node3D = Pistol.instantiate()

var Apple = load("res://Usable/Apple.tscn")
var apple:Node3D = Apple.instantiate()
var apple2:Node3D = Apple.instantiate()
var apple3:Node3D = Apple.instantiate()
var apple4:Node3D = Apple.instantiate()

var inventory:Inventory

func _ready():
	inventory = Inventory.new(hand)
	inventory.add_item(pistol)
	inventory.add_item(apple)
	inventory.add_item(apple2)
	inventory.add_item(apple3)
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			main_skeleton.rotate_y(-event.relative.x * 0.01)
			neck.rotate_x(-event.relative.y * 0.01)
			neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-30), deg_to_rad(45))
	
	
	if event.is_action_pressed("scroll_up"):
		inventory.next()
	elif event.is_action_pressed("scroll_down"):
		inventory.prev()


func _physics_process(delta):
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction:Vector3 = (main_skeleton.transform.basis * Vector3(input_dir.x , 0, input_dir.y)).normalized()
	print(input_dir)
	if _wall_running(delta, direction):
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_impulse
		first_jump = true
	
	if Input.is_action_just_pressed("jump") and not is_on_floor() and can_dubble_jump and first_jump:
		velocity.y += jump_impulse
		first_jump = false
		
	
	if Input.is_action_pressed("sprint"):
		_move(direction, sprint_speed)
	else:
		_move(direction, speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("item_action"):
		inventory.use_item()
	
	# Basic "end game" functionality for the first milestone.
	# TODO: rework
	if get_global_position()[1] < -5:
		get_tree().reload_current_scene()

# This function returns true, if wall running action is happend.
func _wall_running(delta:float, direction:Vector3) -> bool:
	# If the player can't run on the wall. He's just falling down.
	if not can_run_on_wall and is_on_wall_only():
		velocity.y -= fall_acceleration * delta
		return true
	
	# If the player is on the wall and he's able to run on it.
	if can_run_on_wall and is_on_wall_only():
		velocity.y -= fall_acceleration_on_wall * delta
		_move(direction, speed_on_wall)
		return true
		
	return false


# Move the player, based on the direction.
func _move(direction:Vector3, move_speed:int) -> void:
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
		

