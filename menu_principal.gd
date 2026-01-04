extends Control

# Variavel pra chamar a cena do jogo
@export var cena_do_jogo: PackedScene
# Variavel para chamar a tela de como jogar
@export var cena_como_jogar: PackedScene

func _ready():
	
	# Quando apertar Jogar
	$VBoxContainer/BotaoJogar.pressed.connect(entrar_no_jogo)
	
	# Quando apertar Sair
	$VBoxContainer/BotaoSair.pressed.connect(sair_do_jogo)
	
	#	Quando aperta no como jogar
	$VBoxContainer/BotaoComoJogar.pressed.connect(abrir_como_jogar)

func entrar_no_jogo():
	if cena_do_jogo:
		get_tree().change_scene_to_packed(cena_do_jogo)
	else:
		print("ERRO: Nenhuma cena de jogo foi configurada no Inspetor!")

func abrir_como_jogar():
	if cena_como_jogar:
		get_tree().change_scene_to_packed(cena_como_jogar)
	else:
		print("ERRO: Nenhuma cena de como jogar foi configurada no Inspetor.")

func sair_do_jogo():
	# Fecha o jogo
	get_tree().quit()
