extends PathFollow2D

@onready var main = get_tree().root.get_child(0)

func _on_body_entered(body):
	main.restart()
