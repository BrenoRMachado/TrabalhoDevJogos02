extends Node

@export var cena_drone : PackedScene
@export var cena_aranha : PackedScene

@onready var boss = $InimigoBoss
@onready var area_2d = $Area2D
@onready var timer = $Timer
@onready var horda_final = $HordaFinal
@onready var audio_base = $AudioBase
@onready var audio_boss_fight: AudioStreamPlayer = $AudioBossFight

var jogo_acabou = false
var horda_atual = 0

var sequencia_hordas = [
	[],
	[1],
	[2],
	[1, 1],
	[2, 2],
	[1, 1, 2],
	[1, 2, 2]
]

func _ready():
	var player = $Player
	var hud = $Player/HUD
	
	if player:
		player.cor_atual = Global.cor_escolhida.to_lower()
		player.atualizar_visual(0)
		
		if hud:
			hud.player_ref = player

func _process(_delta):
	if jogo_acabou:
		return

	var player = $Player

	if player and player.hp <= 0:
		chamar_game_over()
	
	if boss:
		if boss.hp <= 0:
			print("Vida do Boss zerou!")
			chamar_vitoria()
	else:
		pass

func chamar_game_over():
	jogo_acabou = true
	print("GAME OVER!")
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://tela_game_over.tscn")

func chamar_vitoria():
	jogo_acabou = true
	print("VITÓRIA! O CHEFE FOI DERROTADO!")
	# Espera 2 segundos para chamar a vitória
	await get_tree().create_timer(2.0).timeout 
	get_tree().change_scene_to_file("res://tela_vitoria.tscn")

func aciona_inimigos() -> void:
	print("Cheguei chegando!")
	audio_base.stop()
	audio_boss_fight.play()
	proxima_horda()
	boss.ativar_boss()
	timer.start()

func _on_timer_timeout() -> void:
	horda_atual += 1
	if horda_atual < sequencia_hordas.size():
		proxima_horda()
	else:
		print("Acabaram as hordas")
		timer.stop()

func proxima_horda() -> void:
	var criar_inimigos = sequencia_hordas[horda_atual]
	print("Spawnando horda: ", horda_atual)
	
	for tipo in criar_inimigos:
		var novo_inimigo
		if tipo == 1:
			novo_inimigo = cena_drone.instantiate()
			novo_inimigo.position = Vector2(randf_range(3800, 4300), randf_range(535, 635))
		elif tipo == 2:
			novo_inimigo = cena_aranha.instantiate()
			novo_inimigo.position = Vector2(randf_range(3800, 4000), 635)
		horda_final.add_child(novo_inimigo)
	
