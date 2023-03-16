extends Node

@onready var health_label = get_node("/root/Main/UserInterface/Label")

# Global variables for the player.
signal health_changed
signal player_die

var health:float = 10

func get_heath() -> float:
	return health
	
func heal(i:float) -> void:
	health += i
	health_changed.emit()
	

func damage(i:float) -> void:
	health -= i
	health_changed.emit()
