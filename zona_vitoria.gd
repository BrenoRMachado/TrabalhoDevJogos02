extends Area2D

# Carrega a cena de vitória
var cena_vitoria = load("res://tela_vitoria.tscn")

# (A função _ready foi apagada. Vamos conectar pelo editor)

func _on_body_entered(body):
	print("ALGO ENTROU NA ÁREA: ", body.name) # Esse print vai nos salvar!
	
	if body is CharacterBody2D:
		print("É o Player! Ganhamos!")
		ganhar_jogo()

func ganhar_jogo():
	await get_tree().create_timer(0.5).timeout
	if cena_vitoria:
		get_tree().change_scene_to_packed(cena_vitoria)
	else:
		print("Erro ao carregar a cena de vitória")
