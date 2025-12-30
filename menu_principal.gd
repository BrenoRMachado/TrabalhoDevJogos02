extends Control

# Precisamos dizer para onde o botão jogar vai levar.
# Como o jogo não existe, vamos criar uma variável para isso.
@export var cena_do_jogo: PackedScene

func _ready():
	# Vamos conectar os sinais (cliques) via código para ficar mais limpo,
	# mas você também pode fazer pela aba "Node" na direita.
	
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
