extends CanvasLayer

@onready var lista_paineis = $HBoxContainer.get_children()

var player_ref = null

func _ready():
	var cor = Global.cor_escolhida.capitalize()
	var caminho = "res://assets/Knights/" + cor + "/Life" + cor + ".png"
	var textura = load(caminho)
	
	if textura:
		for painel in lista_paineis:
			var estilo = painel.get_theme_stylebox("panel").duplicate()
			estilo.texture = textura
			painel.add_theme_stylebox_override("panel", estilo)
	else:
		print("Erro ao carregar imagem")

func _process(_delta):
	if player_ref:
		for i in range(lista_paineis.size()):
			lista_paineis[i].visible = i < player_ref.hp
