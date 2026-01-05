extends CanvasLayer

var player_ref = null
# Agora pegamos os Panels
@onready var lista_paineis = $HBoxContainer.get_children()

func _ready():
	var cor = Global.cor_escolhida.capitalize() # Ajusta maiúscula
	var caminho = "res://assets/Knights/" + cor + "/Life" + cor + ".png"
	var textura = load(caminho)
	
	if textura:
		for painel in lista_paineis:
			# PEGA O ESTILO ATUAL DO PAINEL PARA EDITAR
			# "get_stylebox" pega aquele StyleBoxTexture que criamos
			var estilo = painel.get_theme_stylebox("panel").duplicate()
			estilo.texture = textura
			
			# Reaplica o estilo modificado (para não mudar todos ao mesmo tempo sem querer)
			painel.add_theme_stylebox_override("panel", estilo)
	else:
		print("Erro ao carregar imagem")

func _process(delta):
	if player_ref:
		# Lógica de esconder continua igual
		for i in range(lista_paineis.size()):
			lista_paineis[i].visible = i < player_ref.hp
