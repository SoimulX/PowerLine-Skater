extends Node2D

@onready var obstacle_asset = preload("res://Enemies/obstacle.tscn")
@onready var powerline_manager = $"../PowerLine Manager"
@onready var camera = $"../Camera2D"
@onready var space_time = $"../Space-Time Manager"

var rng = RandomNumberGenerator.new()

# PATTERNS = [ PATTERN1, PATTERN2, PATTERN3 ]
# PATTERN1[Y][X]
var patterns = [
	[
		[0, 1, 0],
		[1, 0, 1],
		[0, 1, 0],
	],
	[
		[0, 1, 0],
		[1, 0, 1],
	],
	[
		[1, 0, 1],
		[0, 1, 0],
	],
	[
		[0, 1, 1, 1],
		[1, 0, 1, 1],
		[1, 1, 0, 0],
	],
	[
		[1, 1, 0, 0],
		[1, 0, 1, 1],
		[0, 1, 1, 1],
	],
]

var test_pattern = [
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1],
]

var enemy_rate = 0.1

func _ready():
	#_spaced_random_spawn(50.0, 500.0)
	#_spawn_pattern(50.0, patterns[])
	for i in range(0, 100):
		#await _spawn_pattern(3.0, test_pattern)
		await _spawn_pattern(150.0, patterns[rng.randi_range(0, patterns.size() - 1)])
	#await _spaced_random_spawn(.5, 20000.0)
	
	
func _spawn_obstacle(idx = 0):
	var right_edge = camera.right_edge + 50.0
	
	var obj = obstacle_asset.instantiate()
	powerline_manager.stick_to_grid(obj, right_edge, idx)

func _spaced_random_spawn(space_size, length):
	var x0 = space_time.pos_x
	while space_time.pos_x - x0 < length:
		var rand = rng.randi_range(0, 2)
		_spawn_obstacle(rand)
		
		var x1 = space_time.pos_x
		while space_time.pos_x - x1 < space_size:
			await get_tree().process_frame

func _spawn_pattern(space_size, pattern, height = false):
	var y_size = pattern.size()
	var x_size = pattern[0].size()
	
	var vertical_play = powerline_manager.get_child_count() - y_size
	var vertical_height = rng.randi_range(0, vertical_play) if height == false else height
	
	for x_idx in range(0, x_size):
		var x0 = space_time.pos_x
		
		# Put column of enemies.
		for y_idx in range(0, y_size):
			if pattern[y_idx][x_idx] == 1:
				_spawn_obstacle(y_idx + vertical_height)
				
		# Make a space.
		while space_time.pos_x - x0 < space_size:
			await get_tree().process_frame
