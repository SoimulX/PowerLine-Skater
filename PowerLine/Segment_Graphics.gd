@tool
extends Line2D

func _on_segment_draw():
	var path = $".."
	clear_points()
	for point in path.curve.get_baked_points():
		add_point(point)

func color(col):
	default_color = col
