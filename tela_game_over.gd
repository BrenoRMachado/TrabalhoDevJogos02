extends Control

@onready var audio_game_over: AudioStreamPlayer2D = $AudioGameOver
@onready var audio_touch: AudioStreamPlayer2D = $AudioTouch

func _ready():
	# Conecta os botões
	$VBoxContainer/Button.pressed.connect(_on_tentar_novamente_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_menu_pressed)
	audio_game_over.play()

func _on_tentar_novamente_pressed():
	# Trocamos direto pelo nome do arquivo.
	audio_touch.play()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_menu_pressed():
	audio_touch.play()
	get_tree().change_scene_to_file("res://menu_principal.tscn")
