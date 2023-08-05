extends CharacterBody2D

@onready var animacao = get_node("animacaoMovimento")
const VELOCIDADE_MAXIMA = 200


func _ready():
	pass 

func _process(delta):
	mover()
	animacao_movimento()


func mover() -> void:
	var eixo_x = Input.get_action_strength("mover-para-direita") - Input.get_action_strength("mover-para-esquerda")
	var eixo_y = Input.get_action_strength("mover-para-baixo") - Input.get_action_strength("mover-para-cima")
	var vetor_direcao: Vector2 = Vector2(eixo_x,eixo_y)
	velocity = vetor_direcao.normalized() * VELOCIDADE_MAXIMA
	move_and_slide()
	
func animacao_movimento() -> void:
	if velocity != Vector2.ZERO:
		animacao.play("movendo")
	else:
		animacao.play("parado")
		
	
