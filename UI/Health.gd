extends Label

@onready var player_globals = get_node("/root/Globals") 

func _ready():
	text = "Health: %d" % player_globals.get_heath()
	player_globals.health_changed.connect(_on_health_changed.bind())

func _on_health_changed() -> void:
	text = "Health: %d" % player_globals.get_heath()
