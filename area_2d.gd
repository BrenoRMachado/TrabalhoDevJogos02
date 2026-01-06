extends Area2D

@onready var node = get_parent()

func _on_body_entered(_body: Node2D) -> void:
	node.aciona_inimigos()
	queue_free()
