extends Node2D

@onready var space_time = $"Space-Time Manager"

@onready var score_label = $Score
#@onready var last_score_label = $"Last Score"
#@onready var high_score_label = $"High Score"

var score = 0
var last_score = 0
var high_score = 0

var do_restart = false

#func _ready():
	#_update_last_score()
	
func restart():
	#last_score = score
	do_restart = true

func _process(delta):
	if do_restart:
		get_tree().reload_current_scene()
	
	score = space_time.pos_x / 150.0
	_update_scores()

func _update_scores():
	score_label.text = str(score).pad_decimals(0)
	#
	#if score > high_score:
		#high_score = score
		#_update_high_score()
		
#func _update_last_score():
	#print("has been set %s" % str(last_score).pad_decimals(0))
	#print("been set %s" % str(score).pad_decimals(0))
	#print("set %s" % str(high_score).pad_decimals(0))
	#last_score_label.text = "Last score: %s" % str(last_score).pad_decimals(0)
#
#func _update_high_score():
	#high_score_label.text = "High score: %s" % str(high_score).pad_decimals(0)
	
#func wait_for_next_frame():
	#if not do_restart:
		#await get_tree().process_frame
