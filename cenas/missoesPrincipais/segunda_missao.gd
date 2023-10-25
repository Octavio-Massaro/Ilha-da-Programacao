extends Node2D

var jogador_possui_item: bool = false
@onready var texto: Label = get_node("Interface/Texto")

func _ready():
	VariaveisGlobais.dialogo_atual = "res://DialogoSegundaFase.dialogue"
	texto.text = "Recupere o Cadeado do Mentor"

func _process(_delta):
	if jogador_possui_item and VariaveisGlobais.fim_dialogo:
		jogador_possui_item = false
		await get_tree().create_timer(2.0).timeout
		TelaDeTransicao.caminhoDaCena = "res://cenas/missoesPrincipais/terceira_missao.tscn"
		TelaDeTransicao.aparecer()
	
func trocarDialogo():
	jogador_possui_item = true
	texto.text = "Entregue o item para o Mentor"
	VariaveisGlobais.dialogo_atual = "res://DialogoSegundaFasePt2.dialogue"
