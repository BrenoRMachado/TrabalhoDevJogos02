extends Area2D

@export var distância : float
@export var velocidade : float

@onready var sprite = $AnimatedSprite2D

var posicao_inicial
var auxiliar = 1

func _ready() -> void:
	posicao_inicial = position.y

func _process(delta: float) -> void:
	if distância > 0.0:
		if position.y < posicao_inicial + distância and auxiliar > 0:
			position.y += auxiliar * velocidade * delta
		elif position.y > posicao_inicial - distância and auxiliar < 0:
			position.y += auxiliar * velocidade * delta
		else:
			posicao_inicial = position.y
			auxiliar *= -1
	else:
		sprite.play("default")

func _on_body_entered(body: CharacterBody2D) -> void:
	pass
