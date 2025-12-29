extends Area2D

@export var distância : float
@export var velocidade : float

var posicao_inicial
var auxiliar = 1

func _ready() -> void:
	posicao_inicial = position.x

func _process(delta: float) -> void:
	if distância > 0.0:
		$AnimatedSprite2D.play("default")
		if position.x < posicao_inicial + distância and auxiliar > 0:
			position.x += auxiliar * velocidade * delta
		if position.x > posicao_inicial + distância and auxiliar < 0:
			position.x += auxiliar * velocidade * delta
		else:
			posicao_inicial = position.x
			auxiliar *= -1

func _on_body_entered(body: CharacterBody2D) -> void:
	pass
