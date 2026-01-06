extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var spawn_inicial: Marker2D = $Spawn_Inicial
@onready var spawn_1: Marker2D = $Spawn_1
@onready var spawn_2: Marker2D = $Spawn_2

@onready var area_queda_geral: Area2D = $Queda_mapa
@onready var area_buraco_1: Area2D = $Buraco_1

var checkpoint = false

func _ready() -> void:
	respawn_player(spawn_inicial.global_position)

func respawn_player(posicao_alvo: Vector2) -> void:
	player.global_position = posicao_alvo
	
	player.velocity = Vector2.ZERO
	
	if player.has_method("tomar_dano"):
		player.tomar_dano(1)

func _checkpoint() -> void:
	checkpoint = true

func queda_mapa() -> void:
	
	if not checkpoint:
		print("Caiu no Buraco 1 -> Indo para Spawn 1")
		respawn_player(spawn_1.global_position)
	else:
		print("Caiu do Mapa Geral -> Indo para Spawn 2")
		respawn_player(spawn_2.global_position)
