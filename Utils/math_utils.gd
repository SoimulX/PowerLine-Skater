extends Node

class_name math_utils

# SEARCHES FOR X THAT IS BETWEEN LEFT AND RIGHT.
func binary_search_iteration(expression, x, left, right):
	expression = (left + right) / 2.0
	
	if expression < x:
		left = expression
	elif expression > x:
		right = expression
	#else: return true
	
	return expression
	

# SEARCHES FOR X THAT IS BETWEEN LEFT AND RIGHT.
func binary_search(getter, setter, x, left, right, iters):
	for i in range(iters):
		var t = (left + right) / 2.0
		setter.call(t)
		
		if getter.call() < x:
			left = t
		elif getter.call() > x:
			right = t
		else: break
	
