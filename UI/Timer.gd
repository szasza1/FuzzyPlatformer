extends Label

var time_start:float = 0
var time_now:float = 0
var time_ellapsed:float

func _ready():
	time_start = Time.get_unix_time_from_system()

func _process(_delta):
	time_now = Time.get_unix_time_from_system()
	time_ellapsed = time_now - time_start
	
	text = "Time: %.3f" % time_ellapsed
