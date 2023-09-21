extends Node2D

func _on_area_interacao_body_entered(_body):
	if _body.is_in_group("jogador"):
		get_tree().call_group("missao","trocarDialogo")
		queue_free()
