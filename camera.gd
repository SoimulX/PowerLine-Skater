extends Camera2D

var window_size
	
var right_edge
var left_edge

var top_edge
var bottom_edge

func _ready():
	_update()
	
func _process(delta):
	_update()

func _update():
	window_size = get_viewport_rect().size
	
	right_edge = global_position.x + window_size.x / 2.0
	left_edge = global_position.x - window_size.x / 2.0

	top_edge = global_position.y + window_size.y / 2.0
	bottom_edge = global_position.y - window_size.y / 2.0
