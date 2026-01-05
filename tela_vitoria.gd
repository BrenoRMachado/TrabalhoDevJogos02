extends Control

func _ready():
	# Conectando os botões
	$VBoxContainer/Button.pressed.connect(_on_jogar_novamente_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_menu_pressed)

func _on_jogar_novamente_pressed():
	# Reinicia a fase
	get_tree().change_scene_to_file("res://fase_teste.tscn")

func _on_menu_pressed():
	# Volta pro menu
	get_tree().change_scene_to_file("res://menu_principal.tscn")
