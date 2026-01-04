extends Area2D

@export var distância : float
@export var velocidade : float

@onready var sprite = $AnimatedSprite2D

var posicao_inicial
var auxiliar = 1

func _ready() -> void:
	posicao_inicial = position.x

func _process(delta: float) -> void:
	if distância > 0.0:
		sprite.play("walking")
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
	else:
		sprite.play("default")

func _on_body_entered(body: Node2D) -> void:
	print("Algo encostou")
	if body is CharacterBody2D:
		body.tomar_dano(1)
