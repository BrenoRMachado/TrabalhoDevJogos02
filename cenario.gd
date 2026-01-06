extends Node2D

@onready var spawn_inicial: Marker2D = $Spawn_Inicial
@onready var spawn_1: Marker2D = $Spawn_01
@onready var spawn_2: Marker2D = $Spawn_02

var player : CharacterBody2D
var checkpoint = false

func _ready() -> void:
	player = get_parent().get_node("Player")
	respawn_player(spawn_inicial.global_position)

func respawn_player(posicao_alvo: Vector2) -> void:
	player.global_position = posicao_alvo
	
	player.velocity = Vector2.ZERO

func _checkpoint() -> void:
	checkpoint = true

func queda_mapa() -> void:
	if not checkpoint:
		print("Caiu no Buraco 1 -> Indo para Spawn 1")
		respawn_player(spawn_1.global_position)
		player.tomar_dano(1)
	else:
		print("Caiu do Mapa Geral -> Indo para Spawn 2")
		respawn_player(spawn_2.global_position)
		player.tomar_dano(1)
