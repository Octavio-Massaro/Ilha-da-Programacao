extends Control

func _ao_pressionar_botao_menu():
	TelaDeTransicao.caminhoDaCena = "res://cenas/menu/menu.tscn"
	TelaDeTransicao.aparecer(true)

func _ao_pressionar_botao_sair():
	get_tree().quit()	
