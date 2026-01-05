extends Node2D

func _ready():
	# 1. Acha os nós na cena
	var player = $Player
	var hud = $HUD
	
	if player:
		# Pega o texto do Global (ex: "red")
		var cor = Global.cor_escolhida 
		
		# Injeta no personagem
		player.cor_atual = cor 
		
		# FORÇA ele a atualizar a animação agora
		player.atualizar_visual(0)
		
		print("Personagem pintado de: ", cor)
		
		# --- PARTE DO HUD (Conectando a vida) ---
		if hud:
			hud.player_ref = player
	else:
		print("ERRO: Não achei o CharacterBody2D na cena!")
