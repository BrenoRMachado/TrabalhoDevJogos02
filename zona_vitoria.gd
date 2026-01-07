extends Area2D

var cena_vitoria = load("res://tela_vitoria.tscn")


func _on_body_entered(body):
	print("ALGO ENTROU NA ÁREA: ", body.name)
	
	if body is CharacterBody2D:
		print("É o Player! Ganhamos!")
		ganhar_jogo()

func ganhar_jogo():
	await get_tree().create_timer(0.5).timeout
	if cena_vitoria:
		get_tree().change_scene_to_packed(cena_vitoria)
	else:
		print("Erro ao carregar a cena de vitória")
