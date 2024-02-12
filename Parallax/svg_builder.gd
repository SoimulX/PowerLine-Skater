extends Node2D

@onready var prefab = "res://Parallax/Layers/Mountain Village/1_mountain_village_sprite.tscn"

@export var svg_path : String
@export var node_scale : float

@export var bg_color : Color
@export var fg_color : Color
@export var color_mix_curve : Curve

var svg_util = svg_utils.new()

#func _process(delta):
	#for child in get_children():
		#print(child.position)
# Called when the node enters the scene tree for the first time.
func _ready():
	#var string = "res://Parallax/Layers/Mountain Village/Mountain Village Background.svg"
	var source = svg_util.load_document(svg_path)
	var parts = svg_util.split_into_elements(source)
	
	# Make the last one the first one.
	parts.resize(parts.size()+1)
	for i in range(parts.size()-2, -1, -1):
		parts[i+1] = parts[i]
	parts[0] = parts[-1]
	parts.resize(parts.size()-1)
	
	#var group = Node2D.new()
	#add_child(group)
	
	for i in range(parts.size()):
		var t = i / (parts.size() - 1.0)
		
		var color = lerp(bg_color, fg_color, color_mix_curve.sample(t))
		#t = lerp(t, 0.0, 0.3)
		
		#var color = lerp(Color.NAVAJO_WHITE * .85, Color.DARK_BLUE * .5, t)
		#var color = Color.DARK_BLUE * t
		parts[i] = svg_util.change_color(parts[i], color)
		
		var node = svg_util.element_as_sprite(parts[i])
		node.scale = Vector2.ONE * node_scale
		node.z_index = i-100
		
		var node2 = node.duplicate()
		node2.position.x += 1152
		
		var group = Node2D.new()
		
		group.add_child(node)
		group.add_child(node2)
		
		add_child(group)
		
		#var offset = Vector2()
		#offset = Vector2(0, -300.0) + Vector2.DOWN * i * 100.0
		#node.position = offset
		
