extends Node

# Global variables for the player.
# Health
signal health_changed

var health:float = 10

func get_heath() -> float:
	return health
	
func heal(i:float) -> void:
	health += i
	health_changed.emit()
	
	

func damage(i:float) -> void:
	health -= i
	health_changed.emit()
	if health <= 0:
		health = 10
		get_tree().reload_current_scene()


# Score
var score:int = 0
signal score_increased

func add_score(sc:int) -> void:
	score += sc
	score_increased.emit()
	
# Level Infos
var current_level: int = 1
var spent_time: float = 0
var max_level:int = 3

func next_level() -> void:
	current_level += 1
	
func spent_time_delta(time: float) -> void:
	spent_time = time

func has_next_level() ->bool:
	return current_level <= max_level
