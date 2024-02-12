extends Node2D

# References
@onready var space_time = $"../Space-Time Manager"



func _process(delta):
	var img_size = 1152.0
	
	var n = get_child(0).get_child_count()
	for i in range(get_child(0).get_child_count()):
		var t = i / (n - 1.0)
		
		var x = -fmod(space_time.pos_x * t * 0.8, img_size)
		get_child(0).get_child(i).position.x = x
		#print(get_child(0).name)






## preload, parent, img_size, scroll_speed
#var layers = [
	#parallax_layer.new(
		#preload("res://Parallax/Layers/Mountain Village/1_mountain_village_sprite.tscn"),
		#$".", 1920 * 0.6, 1.0
	#)
#]
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#for layer in layers:
		#var x = -fmod(space_time.pos_x * layer.scroll_speed, layer.img_size) + layer.img_size/2.0
		#layer.set_pos(x)
	#
