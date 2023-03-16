extends Item

@onready var player_globals = get_node("/root/Globals")
@export var add_heal:int = 2


func action() -> void:
	player_globals.heal(add_heal)
