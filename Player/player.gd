extends PathFollow2D

@onready var anim : AnimatedSprite2D = get_node("AnimatedSprite2D")
func _ready():
	anim.play("idle")

#@onready var powerline_manager = get_tree().root.get_child(0).find_child("PowerLine Manager")
#@onready var current_powerline_idx = (powerline_manager.get_child_count() - 1) / 2
#
#var x_offset = 200.0
#var last_direction
#
#func _ready():
	#_change_powerline(current_powerline_idx)
#
#func _input(ev):
	#var input = Vector2.ZERO
	#if Input.is_key_pressed(KEY_W):
		#input.y -= 1
	#if Input.is_key_pressed(KEY_S):
		#input.y += 1
		#
	#var direction = input if input != last_direction else Vector2.ZERO
	#last_direction = input
	#
	#_change_powerline(current_powerline_idx + direction.y)
		#
#func _change_powerline(idx):
	#idx = clamp(idx, 0, powerline_manager.get_child_count() - 1)
	#current_powerline_idx = idx
	#
#func _process(delta):
	#powerline_manager.stick_to_grid(self, x_offset, current_powerline_idx, 12)
#
