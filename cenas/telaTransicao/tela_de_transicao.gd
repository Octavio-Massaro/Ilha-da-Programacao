extends CanvasLayer

const TEMPLATE_AUDIO: PackedScene = preload("res://cenas/templateAudio/template_audio.tscn")
@onready var animacao: AnimationPlayer = get_node("Animacao")
@onready var texto: Label = get_node("Texto")

var caminhoDaCena: String

func aparecer(opcional:bool = false):
	if opcional:
		texto.text = ""
		animacao.play("aparecimento")
	else:
		texto.text = "Missão Concluída"
		criarEfeitoSonoro("res://characters/musicas/Retro Success Melody 04 - electric piano 2.wav")
		animacao.play("aparecimento")
	

func ao_terminar_animacao(anim_name):
	if anim_name == "aparecimento":
		get_tree().change_scene_to_file(caminhoDaCena)
		animacao.play("desaparecimento")


func criarEfeitoSonoro(caminhoAudio:String):
	var audio = TEMPLATE_AUDIO.instantiate()
	audio.efeitoSonoro = caminhoAudio
	add_child(audio)
