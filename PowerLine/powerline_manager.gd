extends Node2D

func stick_to_grid(node : PathFollow2D, x : float, idx : int, iters : int = 10):
	var powerline = get_child(idx)
	if powerline == null:
		print("There is no PowerLine at that index!")
		return
	if powerline.has_method("stick_to_x"):
		powerline.stick_to_x(node, x, iters)
