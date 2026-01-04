extends CharacterBody2D

# Configurações de movimento
@export var velocidade = 250.0
@export var gravidade = 1000.0
@export var forca_pulo = -450.0 # Ajustado para não ser tão alto

# Variáveis de controle de ataque
var pode_atacar = true
var ataque_alternado = false

@onready var sprite = $AnimatedSprite2D
@onready var area_ataque_col = $AreaAtaque/CollisionShape2D

func _physics_process(delta):
	# 1. Gravidade
	if not is_on_floor():
		velocity.y += gravidade * delta

	# 2. Movimento Horizontal (Setas ou A/D)
	var direcao = 0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direcao += 1
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direcao -= 1

	# 3. Lógica de Velocidade e Animações (Andar/Parado)
	if direcao != 0:
		velocity.x = direcao * velocidade
		sprite.flip_h = (direcao < 0)
		# Reposiciona a hitbox da espada para frente do player
		$AreaAtaque.position.x = 30 if direcao > 0 else -30
		
		if is_on_floor() and pode_atacar:
			sprite.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
		if is_on_floor() and pode_atacar:
			sprite.play("default")

	# 4. Pulo e Animação de Ar
	if is_on_floor() and (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_W)):
		velocity.y = forca_pulo
	
	if not is_on_floor() and pode_atacar:
		sprite.play("jumping")

	# 5. Comando de Ataque (Tecla X ou Clique Esquerdo)
	if (Input.is_key_pressed(KEY_X) or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and pode_atacar:
		atacar()

	move_and_slide()

func atacar():
	pode_atacar = false
	
	# Alterna entre as animações hitting e hitting2
	if ataque_alternado:
		sprite.play("hitting2")
	else:
		sprite.play("hitting")
	
	# Inverte para o próximo ataque
	ataque_alternado = !ataque_alternado
	
	# Ativa a colisão da espada
	area_ataque_col.disabled = false 
	
	# Tempo da animação de ataque (ajuste se necessário)
	await get_tree().create_timer(0.4).timeout
	
	area_ataque_col.disabled = true
	pode_atacar = true
