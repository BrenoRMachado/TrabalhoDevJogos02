extends Node2D

@export var tela_game_over: PackedScene

# Variáveis globais do script
var player = null
var jogo_acabou = false

func _ready():
	# 1. Acha os nós na cena
	player = $Player
	var hud = $HUD
	
	if player:
		# Pega o texto do Global e força minúsculo para garantir a animação
		var cor = Global.cor_escolhida
		
		# Injeta no personagem
		player.cor_atual = cor.to_lower()
		
		# FORÇA ele a atualizar a animação agora
		player.atualizar_visual(0)
		
		print("Personagem pintado de: ", cor)
		
		if hud:
			hud.player_ref = player
	else:
		print("ERRO: Não achei o nó 'Player' na cena! Verifique o nome.")

func _process(delta):
	# Vigia a vida do jogador o tempo todo
	if player and not jogo_acabou:
		if player.hp <= 0:
			chamar_game_over()

func chamar_game_over():
	jogo_acabou = true
	print("GAME OVER! Mudando de tela...")
	
	# Espera 1 segundo antes de sair
	await get_tree().create_timer(1.0).timeout
	
	if tela_game_over:
		get_tree().change_scene_to_packed(tela_game_over)
	else:
		print("ERRO: Você esqueceu de colocar a TelaGameOver no Inspector da Fase!")
