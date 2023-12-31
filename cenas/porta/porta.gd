extends Area2D

const TEMPLATE_AUDIO: PackedScene = preload("res://cenas/templateAudio/template_audio.tscn")
@onready var animacao: AnimationPlayer = get_node("Animacao")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _ao_entrar_na_area_da_porta(_body):
	if _body.is_in_group("jogador"):
		animacao.play("aberta")
	


func _ao_sair_da_area_da_porta(_body):
	if _body.is_in_group("jogador"):
		animacao.play("fechada")
		
		
func criarEfeitoSonoro(caminhoAudio:String):
	var audio = TEMPLATE_AUDIO.instantiate()
	audio.efeitoSonoro = caminhoAudio
	add_child(audio)
