extends CharacterBody2D

# Variáveis de movimento
@export var velocidade = 200.0
@export var forca_pulo = -350.0
var gravidade = 980
var pode_atacar = true

# Referências aos nós
@onready var sprite = $AnimatedSprite2D
@onready var area_ataque_col = $AreaAtaque/CollisionShape2D
@onready var camera = $Camera2D

func _physics_process(delta):
	# 1. Gravidade
	if not is_on_floor():
		velocity.y += gravidade * delta

	# 2. Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = forca_pulo

	# 3. Movimento Horizontal
	var direcao = Input.get_axis("ui_left", "ui_right")
	if direcao:
		velocity.x = direcao * velocidade
		sprite.flip_h = (direcao < 0)
		# Ajusta a posição da área de ataque para frente do player
		$AreaAtaque.position.x = 20 if direcao > 0 else -20
		if is_on_floor(): sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
		if is_on_floor(): sprite.play("idle")

	if not is_on_floor():
		sprite.play("jump")

	# 4. Comando de Ataque (Tecla Z ou J)
	if Input.is_action_just_pressed("atacar") and pode_atacar:
		atacar()

	move_and_slide()

func atacar():
	pode_atacar = false
	sprite.play("attack")
	area_ataque_col.disabled = false # Ativa a hitbox da espada
	
	# REQUISITO: Animação não-sprite (Tremor leve de câmera ao atacar)
	var tween = create_tween()
	tween.tween_property(camera, "offset", Vector2(2, 2), 0.05)
	tween.tween_property(camera, "offset", Vector2(-2, -2), 0.05)
	tween.tween_property(camera, "offset", Vector2(0, 0), 0.05)
	
	await get_tree().create_timer(0.2).timeout
	area_ataque_col.disabled = true # Desativa a espada
	
	await get_tree().create_timer(0.3).timeout # Tempo de espera entre golpes
	pode_atacar = true

# Função para os inimigos te matarem
func tomar_dano():
	get_tree().reload_current_scene()


func _on_area_ataque_area_entered(area: Area2D) -> void:
	if area.has_method("receber_dano"):
		area.receber_dano()
