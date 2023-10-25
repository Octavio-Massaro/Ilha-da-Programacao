extends Control

func _ao_pressionar_novoJogo():
	TelaDeTransicao.caminhoDaCena = "res://cenas/missoesPrincipais/primeira_missao.tscn"
	TelaDeTransicao.aparecer(true)


func _ao_pressionar_controles():
	get_tree().change_scene_to_file("res://cenas/controles/controles.tscn")


func _ao_pressionar_sair():
	get_tree().quit()
