extends Control

func _ready():
	$VBoxContainer/Button.pressed.connect(_on_jogar_novamente_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_menu_pressed)

func _on_jogar_novamente_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menu_principal.tscn")
