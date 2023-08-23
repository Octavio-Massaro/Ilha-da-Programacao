extends Node2D

var fim_dialogo: bool
signal congela()


func _ready():
	congela.connect(testar)
	
func testar():
	pass
	
