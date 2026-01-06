extends Area2D

@onready var node = get_parent()

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		node._checkpoint()
