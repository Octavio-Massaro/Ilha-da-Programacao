extends Node2D

var contador_inimigos_derrotados: int = 0
@export var inimigos_necessarios_para_progredir: int = 5
@onready var texto: Label = get_node("Interface/Texto")

func _ready():
	VariaveisGlobais.dialogo_atual = "res://DialogoPrimeiraFase.dialogue"


func _process(_delta):
	pass
	
	
func contabilizar_inimigos_derrotados():
	contador_inimigos_derrotados += 1
	
	if contador_inimigos_derrotados == inimigos_necessarios_para_progredir:
		await get_tree().create_timer(2.0).timeout
		texto.visible = false
		TelaDeTransicao.caminhoDaCena = "res://cenas/missoesPrincipais/segunda_missao.tscn" 
		TelaDeTransicao.aparecer()
		
