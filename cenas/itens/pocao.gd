extends Node2D

func _on_area_interacao_body_entered(body):
	if body.is_in_group("jogador"):
		body.vida = body.vida_maxima;
		queue_free()
