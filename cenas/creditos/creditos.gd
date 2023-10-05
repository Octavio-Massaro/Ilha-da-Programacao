extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _ao_pressionar_botao_menu():
	TelaDeTransicao.caminhoDaCena = "res://cenas/menu/menu.tscn"
	TelaDeTransicao.aparecer(true)

func _ao_pressionar_botao_sair():
	get_tree().quit()


	
