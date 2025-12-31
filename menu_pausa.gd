extends CanvasLayer

# Variável para Voltar ao Menu
@export var cena_menu_principal: String = "res://menu_principal.tscn"

func _ready():
	# O menu começa invisível
	visible = false 
	
	# Conecta os botões
	$Control/VBoxContainer/BotaoContinuar.pressed.connect(despausar)
	$Control/VBoxContainer/BotaoMenu.pressed.connect(voltar_menu)
	$Control/VBoxContainer/BotaoSair.pressed.connect(sair)

func _unhandled_input(event):
	# Se apertar ESC
	if event.is_action_pressed("ui_cancel"):
		# Se já estiver visível, despausa. Se não, pausa.
		if visible:
			despausar()
		else:
			pausar()

func pausar():
	visible = true
	get_tree().paused = true # CONGELA O JOGO

func despausar():
	visible = false
	get_tree().paused = false # DESCONGELA O JOGO

func voltar_menu():
	# Descongela antes de trocar a cena
	get_tree().paused = false 
	get_tree().change_scene_to_file(cena_menu_principal)

func sair():
	get_tree().quit()
