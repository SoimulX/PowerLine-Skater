@tool
extends Node2D

@onready var segment_asset = preload("res://PowerLine/segment.tscn")
@onready var space_time = get_tree().root.get_child(0).find_child("Space-Time Manager")
@onready var camera = get_tree().root.get_child(0).find_child("Camera2D")

var util = math_utils.new()

var segments = []
var segment_size : float
var old_pos : float

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# FACADE

func stick_to_x(node : PathFollow2D, x : float, iters : int = 10):
	if segments[-1].global_position.x + segment_size < x:
		return false
	
	for segment in segments:
		if segment.global_position.x + segment_size > x:
			if node.get_parent() == null:
				segment.add_child(node)
			else: node.reparent(segment)
			
			node.position = Vector2.ZERO
			node.progress_ratio = 0.0
			
			var getter = func():
				return node.global_position.x
			var setter = func(t):
				node.progress_ratio = t
			util.binary_search(getter, setter, x, 0.0, 1.0, iters)
			
			## Binary search the progress_ratio
			## for the right x position.
			#var left = 0.0
			#var right = 1.0
			#for i in range(0, 10):
				#node.progress_ratio = (left + right) / 2.0
				#
				#if node.global_position.x < x:
					#left = node.progress_ratio
				#elif node.global_position.x > x:
					#right = node.progress_ratio
				#else: break
			
			break

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# ENTRIES

func _ready():
	var cv = _make_segment().curve
	segment_size = cv.get_point_position(cv.point_count - 1).x - cv.get_point_position(0).x
	_update_powerline()

func _process(delta):
	_update_powerline()

func _on_item_rect_changed():
	print("drew")
	_update_powerline()

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# BACKEND

func _update_powerline():
	if Engine.is_editor_hint():
		return
		
	#print(segments.size())

	
	if segments.size() == 0:
		_make_segment()
	
	_update_pos()
	_fill_screen_to_the_right(camera.right_edge)
	_delete_segments_to_the_left(camera.left_edge)


func _fill_screen_to_the_right(right_edge):
	while segments[-1].global_position.x + segment_size < right_edge:
		_make_segment()
		segments[-1].position.x = segments[-2].position.x + segment_size
		

func _delete_segments_to_the_left(left_edge):
	for segment in segments:
		if segment.global_position.x + segment_size < left_edge: # or segment.global_position.x > right_edge:
			segment.queue_free()
			segments.erase(segment)


func _make_segment():
	var segment = segment_asset.instantiate()
	add_child(segment)
	segments.append(segment)
	#var col = Color8(rng.randi_range(0, 255), rng.randi_range(0, 255), rng.randi_range(0, 255))
	#powerline.get_child(0).default_color = col
	return segment
	

func _update_pos():
	var new_pos = space_time.pos_x
	var delta = old_pos - new_pos
	for segment in segments:
		segment.position.x += delta
	old_pos = new_pos
