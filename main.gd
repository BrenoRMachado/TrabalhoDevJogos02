extends Node

@onready var boss = $InimigoBoss
@onready var area_2d = $Area2D
@onready var timer = $Timer

var jogo_acabou = false
var inimigos_ativos = false

func _ready():
	# --- CONFIGURAÇÃO INICIAL ---
	var player = $Player
	var hud = $Player/HUD
	
	if player:
		# Pinta o personagem
		player.cor_atual = Global.cor_escolhida.to_lower()
		player.atualizar_visual(0)
		
		# Liga o HUD
		if hud:
			hud.player_ref = player

func _process(_delta):
	# Se o jogo já acabou, pare de verificar
	if jogo_acabou:
		return

	var player = $Player

	# --- LÓGICA DE DERROTA ---
	if player and player.hp <= 0:
		chamar_game_over()
	
	# 1. Verifica se o Boss ainda existe na cena
	if boss:
		# 2. Vê a vida do boss
		if boss.hp <= 0:
			print("Vida do Boss zerou!")
			chamar_vitoria()
	else:
		pass

func chamar_game_over():
	jogo_acabou = true
	print("GAME OVER!")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://tela_game_over.tscn")

func chamar_vitoria():
	jogo_acabou = true
	print("VITÓRIA! O CHEFE FOI DERROTADO!")
	# Espera 2 segundos para chamar a vitória
	await get_tree().create_timer(2.0).timeout 
	get_tree().change_scene_to_file("res://tela_vitoria.tscn")

func aciona_inimigos() -> void:
	print("Cheguei chegando!")
	timer.start(10.0)
	inimigos_ativos = true
	boss.ativar_boss()

func _on_timer_timeout() -> void:
	pass
	
