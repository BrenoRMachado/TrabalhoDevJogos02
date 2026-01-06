extends Control

@onready var audio_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	$BotaoVoltar.pressed.connect(_on_voltar_pressed)

func _on_voltar_pressed():
	audio_2d.play()
	await audio_2d.finished
	get_tree().change_scene_to_file("res://menu_principal.tscn")

func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(str(meta))
