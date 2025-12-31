extends Control

# Variavel pra chamar a cena do jogo
@export var cena_do_jogo: PackedScene

func _ready():
	
	# Quando apertar Jogar
	$VBoxContainer/BotaoJogar.pressed.connect(entrar_no_jogo)
	
	# Quando apertar Sair
	$VBoxContainer/BotaoSair.pressed.connect(sair_do_jogo)

func entrar_no_jogo():
	if cena_do_jogo:
		get_tree().change_scene_to_packed(cena_do_jogo)
	else:
		print("ERRO: Nenhuma cena de jogo foi configurada no Inspector!")

func sair_do_jogo():
	# Fecha o jogo
	get_tree().quit()
