extends Area2D

@export var amplitude : float
@export var velocidade : float

@onready var sprite = $AnimatedSprite2D
@onready var audio_dano = $AudioStreamPlayer2D

var tempo = 0.0
var posicao_inicial

func _ready() -> void:
	posicao_inicial = position.y
	
func _process(delta: float) -> void:
	tempo += delta * velocidade
	
	position.y = posicao_inicial + (sin(tempo) * amplitude)

func _on_body_entered(body: Node2D) -> void:
	print("Algo encostou")
	if body is CharacterBody2D:
		body.tomar_dano(1)

func aplica_dano() -> void:
	audio_dano.play()
	await audio_dano.finished
	queue_free()
