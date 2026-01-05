extends Control

@export var cena_jogo: PackedScene

@onready var audio_touch = $AudioTouch


func _ready():
	# Botão Vermelho
	$HBoxContainer/VBoxContainer/Button.pressed.connect(_on_vermelho_pressed)
	
	# Botão Azul
	$HBoxContainer/VBoxContainer2/Button.pressed.connect(_on_azul_pressed)
	
	# Botão Preto
	$HBoxContainer/VBoxContainer3/Button.pressed.connect(_on_preto_pressed)
	
	# Botão Roxo
	$HBoxContainer/VBoxContainer4/Button.pressed.connect(_on_roxo_pressed)
	

func _on_vermelho_pressed():
	audio_touch.play()
	await audio_touch.finished
	Global.cor_escolhida = "red"
	iniciar_jogo()

func _on_azul_pressed():
	audio_touch.play()
	await audio_touch.finished
	Global.cor_escolhida = "blue"
	iniciar_jogo()
	
func _on_preto_pressed():
	audio_touch.play()
	await audio_touch.finished
	Global.cor_escolhida = "black"
	iniciar_jogo()
	
func _on_roxo_pressed():
	audio_touch.play()
	await audio_touch.finished
	Global.cor_escolhida = "purple"
	iniciar_jogo()

func iniciar_jogo():
	if cena_jogo:
		get_tree().change_scene_to_packed(cena_jogo)
	else:
		print("ERRO: Esqueceu de colocar a FaseTeste no Inspector!")
