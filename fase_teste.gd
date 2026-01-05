extends Node2D

func _ready():
	# Tenta achar o personagem pelo nome. 
	# Se na sua lista ele se chama "Jogador", mude aqui dentro dos parênteses!
	var player = $Player
	
	if player:
		# Pega a cor que veio da tela de seleção
		var cor = Global.cor_escolhida
		print("Aplicando cor: ", cor)
		
		# Aplica no personagem
		player.cor_atual = cor
		player.atualizar_visual(0)
	else:
		print("ERRO: Esqueci de colocar o boneco na cena ou o nome está errado!")
