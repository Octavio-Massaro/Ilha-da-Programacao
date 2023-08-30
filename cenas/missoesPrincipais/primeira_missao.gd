extends Node2D

var contador_inimigos_derrotados: int = 0
@export var inimigos_necessarios_para_progredir: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	VariaveisGlobais.dialogo_atual = "res://DialogoPrimeiraFase.dialogue"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func contabilizar_inimigos_derrotados():
	contador_inimigos_derrotados += 1
	
	if contador_inimigos_derrotados == inimigos_necessarios_para_progredir:
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://cenas/missoesPrincipais/segunda_missao.tscn")
