extends Node

# Global variables for the player.
# Health
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


# Score
var score:int = 0
signal score_increased

func add_score(sc:int) -> void:
	score += sc
	score_increased.emit()
	
