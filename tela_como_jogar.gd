extends Control

func _ready():
	$BotaoVoltar.pressed.connect(_on_voltar_pressed)

func _on_voltar_pressed():
	# Troca de volta para a cena do Menu Principal
	# Certifique-se de escrever o caminho exato do seu arquivo
	get_tree().change_scene_to_file("res://menu_principal.tscn")
