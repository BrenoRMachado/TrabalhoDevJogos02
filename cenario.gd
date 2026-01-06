extends Node2D

# Referências aos nós da cena
@onready var player: CharacterBody2D = $Player
@onready var spawn_1: Marker2D = $Spawn_1  # Certifique-se de criar este Marker2D na cena
@onready var spawn_2: Marker2D = $Spawn_2  # Certifique-se de criar este Marker2D na cena

# Referências às áreas de morte
@onready var area_queda_geral: Area2D = $Queda_mapa
@onready var area_buraco_1: Area2D = $"Buraco_1" # Aspas necessárias pois há espaço no nome

func _ready() -> void:
	# Conectando os sinais de "corpo entrou" via código
	# Isso detecta quando o CharacterBody2D (Player) encosta na área
	if not area_queda_geral.body_entered.is_connected(_on_queda_mapa_body_entered):
		area_queda_geral.body_entered.connect(_on_queda_mapa_body_entered)
	
	if not area_buraco_1.body_entered.is_connected(_on_buraco_1_body_entered):
		area_buraco_1.body_entered.connect(_on_buraco_1_body_entered)

func _process(delta: float) -> void:
	pass

# --- LÓGICA DE RESPAWN ---

# Função genérica para resetar o jogador
func respawn_player(posicao_alvo: Vector2) -> void:
	# 1. Move o jogador para a posição do Marker2D
	player.global_position = posicao_alvo
	
	# 2. Reseta a velocidade (IMPORTANTE: senão ele respawna caindo muito rápido)
	player.velocity = Vector2.ZERO
	
	# 3. Aplica o dano usando o método que já existe no seu player.gd
	if player.has_method("tomar_dano"):
		player.tomar_dano(1)

# Sinal disparado ao cair no Buraco 1
func _on_buraco_1_body_entered(body: Node2D) -> void:
	if body == player:
		print("Caiu no Buraco 1 -> Indo para Spawn 1")
		# call_deferred é usado para evitar erros de física ao mudar posição durante colisão
		call_deferred("respawn_player", spawn_1.global_position)

# Sinal disparado ao cair no resto do mapa (Queda_mapa)
func _on_queda_mapa_body_entered(body: Node2D) -> void:
	if body == player:
		print("Caiu do Mapa Geral -> Indo para Spawn 2")
		call_deferred("respawn_player", spawn_2.global_position)
