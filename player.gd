extends CharacterBody2D

@export var velocidade = 250.0
@export var forca_pulo = -450.0
@export var gravidade = 1000.0
@export_enum("black", "purple", "red", "blue") var cor_atual: String = "blue"

var pode_atacar = true
var esta_atacando = false
var combo_ataque = 1
var hp = 5
var levando_dano = false
var morto = false

@onready var sprite = $AnimatedSprite2D
@onready var area_ataque = $AreaAtaque
@onready var colisao_ataque = $AreaAtaque/CollisionShape2D
@onready var jump_audio = $JumpAudio
@onready var sword_audio = $SwordAudio
@onready var hurt_audio = $HurtAudio
@onready var death_audio: AudioStreamPlayer2D = $DeathAudio


func _physics_process(delta: float) -> void:
	if morto:
		return

	if not is_on_floor():
		velocity.y += gravidade * delta

	if is_on_floor() and Input.is_action_just_pressed("pular"):
		velocity.y = forca_pulo
		jump_audio.play()

	var direcao = Input.get_axis("esquerda", "direita")
	
	if not esta_atacando:
		if direcao != 0:
			velocity.x = direcao * velocidade
			sprite.flip_h = (direcao < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, velocidade)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, velocidade)

	if sprite.flip_h:
		area_ataque.position.x = -24
	else:
		area_ataque.position.x = 24

	if Input.is_action_just_pressed("atacar") and pode_atacar:
		atacar()
		sword_audio.play()

	move_and_slide()
	atualizar_visual(direcao)

func atualizar_visual(direcao: float):
	if esta_atacando or levando_dano:
		return

	var anim_desejada : String

	if not is_on_floor():
		anim_desejada = cor_atual + "_jump"
	elif direcao != 0:
		anim_desejada = cor_atual + "_run"
	else:
		anim_desejada = cor_atual + "_idle"

	if sprite.animation != anim_desejada:
		sprite.play(anim_desejada)

func atacar():
	pode_atacar = false
	esta_atacando = true
	
	sprite.play(cor_atual + "_attack" + str(combo_ataque))
	colisao_ataque.disabled = false
	
	await get_tree().physics_frame
	
	var alvos = area_ataque.get_overlapping_areas()
	
	for alvo in alvos:
		if alvo.has_method("aplica_dano"):
			alvo.aplica_dano()
	
	await sprite.animation_finished
	
	colisao_ataque.disabled = true
	esta_atacando = false
	combo_ataque = 2 if combo_ataque == 1 else 1
	
	await get_tree().create_timer(0.3).timeout
	pode_atacar = true

func tomar_dano(dano : int) -> void:
	if morto or levando_dano: return 
	
	hp -= dano
	print("Vida do personagem: ", hp)

	if hp <= 0:
		morrer()
	else:
		processar_dano_comum()

func processar_dano_comum():
	levando_dano = true
	hurt_audio.play()
	sprite.play(cor_atual + "_damage")
	
	await sprite.animation_finished
	levando_dano = false

func morrer():
	morto = true
	velocity = Vector2.ZERO
	death_audio.play()
	sprite.play("death")
