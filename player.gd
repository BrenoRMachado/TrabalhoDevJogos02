extends CharacterBody2D

# Configurações de movimento
@export var velocidade = 250.0
@export var gravidade = 1000.0
@export var forca_pulo = -450.0 # Ajustado para não ser tão alto
@export var tempo_recarga_ataque = 0.6 # Tempo total que ele fica sem poder bater de novo

# Variáveis de controle de ataque
var pode_atacar = true
var ataque_alternado = false
var esta_atacando = false
var hp = 5

@onready var sprite = $AnimatedSprite2D
@onready var area_ataque_col = $AreaAtaque/CollisionShape2D

func _physics_process(delta):
	# 1. Gravidade
	if not is_on_floor():
		velocity.y += gravidade * delta

	# 2. Movimento Horizontal
	var direcao = 0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direcao += 1
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direcao -= 1

	# 3. Lógica de Velocidade e Animações (O segredo está aqui!)
	if direcao != 0:
		velocity.x = direcao * velocidade
		sprite.flip_h = (direcao < 0)
		# Se não estiver com a espada no ar, pode mostrar que está andando
		if is_on_floor() and not esta_atacando:
			sprite.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
		if is_on_floor() and not esta_atacando:
			sprite.play("default")

	# 4. Pulo
	if is_on_floor() and (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W)):
		velocity.y = forca_pulo
	
	# SÓ toca "jumping" se NÃO estiver atacando
	if not is_on_floor() and not esta_atacando:
		sprite.play("jumping")

	# 5. Comando de Ataque
	if (Input.is_key_pressed(KEY_X) or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and pode_atacar:
		atacar()

	move_and_slide()

func atacar():
	pode_atacar = false
	esta_atacando = true # Começou o movimento do golpe
	
	if ataque_alternado:
		sprite.play("hitting2")
	else:
		sprite.play("hitting")
	
	ataque_alternado = !ataque_alternado
	area_ataque_col.disabled = false 
	
	# Tempo da animação (ele fica travado no golpe)
	await get_tree().create_timer(0.4).timeout
	
	area_ataque_col.disabled = true
	esta_atacando = false # AQUI ele já pode voltar a andar/pular visualmente!
	
	# Tempo de espera (Cooldown) para poder clicar de novo
	await get_tree().create_timer(tempo_recarga_ataque).timeout
	
	pode_atacar = true

func tomar_dano(dano : int) -> void:
	hp -= dano
	print("Vida do personagem: ", hp)
