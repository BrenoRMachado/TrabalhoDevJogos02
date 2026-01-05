extends CanvasLayer

@export var cena_menu_principal: String = "res://menu_principal.tscn"

@onready var audio_touch: AudioStreamPlayer2D = $AudioTouch


func _ready():
	visible = false 

	$Control/VBoxContainer/BotaoContinuar.pressed.connect(despausar)
	$Control/VBoxContainer/BotaoMenu.pressed.connect(voltar_menu)
	$Control/VBoxContainer/BotaoSair.pressed.connect(sair)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			despausar()
		else:
			pausar()

func pausar():
	visible = true
	get_tree().paused = true # CONGELA O JOGO

func despausar():
	visible = false
	audio_touch.play()
	await audio_touch.finished
	get_tree().paused = false # DESCONGELA O JOGO

func voltar_menu():
	# Descongela antes de trocar a cena
	get_tree().paused = false 
	audio_touch.play()
	await audio_touch.finished
	get_tree().change_scene_to_file(cena_menu_principal)

func sair():
	audio_touch.play()
	await audio_touch.finished
	get_tree().quit()
