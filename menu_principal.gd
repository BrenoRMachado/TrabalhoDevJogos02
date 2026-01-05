extends Control

@export var cena_do_jogo: PackedScene
@export var cena_como_jogar: PackedScene
@export var cena_creditos: PackedScene

@onready var audio_touch: AudioStreamPlayer2D = $AudioTouch


func _ready():
	
	# Quando apertar Jogar
	$VBoxContainer/BotaoJogar.pressed.connect(entrar_no_jogo)
	
	# Quando apertar Sair
	$VBoxContainer/BotaoSair.pressed.connect(sair_do_jogo)
	
	# Quando aperta no como jogar
	$VBoxContainer/BotaoComoJogar.pressed.connect(abrir_como_jogar)
	
	# Quando aperta no créditos
	$VBoxContainer/BotaoCreditos.pressed.connect(abrir_creditos)

func entrar_no_jogo():
	if cena_do_jogo:
		audio_touch.play()
		await audio_touch.finished
		get_tree().change_scene_to_packed(cena_do_jogo)
	else:
		print("ERRO: Nenhuma cena de jogo foi configurada no Inspetor!")

func abrir_como_jogar():
	if cena_como_jogar:
		audio_touch.play()
		await audio_touch.finished
		get_tree().change_scene_to_packed(cena_como_jogar)
	else:
		print("ERRO: Nenhuma cena de como jogar foi configurada no Inspetor.")

func abrir_creditos():
	if cena_creditos:
		audio_touch.play()
		await audio_touch.finished
		get_tree().change_scene_to_packed(cena_creditos)
	else:
		print("ERRO: Nenhuma cena de créditos foi configurada no Inspetor.")

func sair_do_jogo():
	# Fecha o jogo
	audio_touch.play()
	await audio_touch.finished
	get_tree().quit()
