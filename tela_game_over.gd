extends Control

func _ready():
	# Conecta os botões
	$VBoxContainer/Button.pressed.connect(_on_tentar_novamente_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_menu_pressed)

func _on_tentar_novamente_pressed():
	# Trocamos direto pelo nome do arquivo.
	get_tree().change_scene_to_file("res://fase_teste.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menu_principal.tscn")
