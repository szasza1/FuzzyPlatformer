extends Label

@onready var player_globals = get_node("/root/Globals") 

func _ready():
	text = "Score: %d" % player_globals.score
	player_globals.score_increased.connect(_on_score_changed.bind())

func _on_score_changed() -> void:
	text = "Score: %d" % player_globals.score
