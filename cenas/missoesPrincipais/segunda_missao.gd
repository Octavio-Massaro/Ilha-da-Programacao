extends Node2D

var jogador_possui_item: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	VariaveisGlobais.dialogo_atual = "res://DialogoSegundaFase.dialogue"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jogador_possui_item and VariaveisGlobais.fim_dialogo:
		jogador_possui_item = false
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://cenas/missoesPrincipais/primeira_missao.tscn")
	
	
	
func trocarDialogo():
	jogador_possui_item = true
	VariaveisGlobais.dialogo_atual = "res://teste.dialogue"
