extends Area2D

@export var distância : float
@export var velocidade : float
@export var player: CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer

var posicao_inicial
var auxiliar = -1
var verificador_timer = false
var ataque_inimigo = false
var presenca_jogador = false
var aux_jogador = true

func _ready() -> void:
	posicao_inicial = position.x
	sprite.play("default")
	timer.start(2.0)

func _process(delta: float) -> void:
	if verificador_timer == true:
		if position.x < posicao_inicial + distância and auxiliar > 0:
			position.x += auxiliar * velocidade * delta
		elif position.x > posicao_inicial - distância and auxiliar < 0:
			position.x += auxiliar * velocidade * delta
		else:
			posicao_inicial = position.x
			auxiliar *= -1
			if sprite.flip_h == false:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
			sprite.play("atack")
			ataque_inimigo = true
			verificador_timer = false
			timer.start(3.0)
	
	if ataque_inimigo and presenca_jogador and aux_jogador:
		player.tomar_dano(1)
		aux_jogador = false

func _on_timer_timeout() -> void:
	verificador_timer = true
	ataque_inimigo = false
	aux_jogador = true
	sprite.play("walking")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "atack":
		sprite.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		presenca_jogador = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		presenca_jogador = false
