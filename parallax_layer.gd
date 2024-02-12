class_name parallax_layer extends Node

# References
@onready var main = $"."

var asset
var instance1
var instance2

var img_size : float
var scroll_speed : float

func _init(passed_asset, parent : Node, passed_img_size : float = 1920 * 0.6, passed_scroll_speed = 1.0):
	asset = passed_asset
	instance1 = asset.instantiate()
	instance2 = asset.instantiate()
	parent.add_child(instance1)
	parent.add_child(instance2)
	
	img_size = passed_img_size
	scroll_speed = passed_scroll_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_pos(x):
	instance1.position.x = x
	instance2.position.x = x + img_size
