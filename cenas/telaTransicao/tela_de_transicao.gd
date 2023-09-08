extends CanvasLayer

@onready var animacao: AnimationPlayer = get_node("Animacao")

var caminhoDaCena: String

func aparecer():
	animacao.play("aparecimento")
	


func ao_terminar_animacao(anim_name):
	if anim_name == "aparecimento":
		get_tree().change_scene_to_file(caminhoDaCena)
		animacao.play("desaparecimento")
