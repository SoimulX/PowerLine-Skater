extends Node2D

# Constant-like
@export var acceleration : float = 15

# Variables
@export var speed : float = 360

var pos_x : float = 0
var time : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	speed += acceleration * delta
	pos_x += speed * delta
