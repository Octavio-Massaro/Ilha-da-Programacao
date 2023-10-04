extends Node2D

@onready var texto: Label = get_node("Interface/Texto")
var condicaoVitoria: bool = false

func _ready():
	VariaveisGlobais.dialogo_atual = "res://DialogoTerceiraFase.dialogue"
	texto.text = "  Derrote Dark code  "



func _process(_delta):
	if condicaoVitoria:
		await get_tree().create_timer(2.0).timeout
		TelaDeTransicao.caminhoDaCena = "res://cenas/missoesPrincipais/primeira_missao.tscn"
		TelaDeTransicao.aparecer()
		
	
	
func darkCodeDerrotado():
	condicaoVitoria = true;

