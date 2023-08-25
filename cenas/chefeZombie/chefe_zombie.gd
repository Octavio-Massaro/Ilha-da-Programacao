extends CharacterBody2D

var referencia_jogador = null
var MOVE_SPEED = 100
var vida: int = 3
var dano: int = 2
var pode_atacar: bool = true

@onready var animacao: AnimatedSprite2D = get_node("Animacao")
func _ready():
	pass 


func _process(delta):
	pass
	

func _physics_process(delta):
	animar()
	if referencia_jogador != null:
		perseguir()
	


func perseguir():
	var direcao = global_position.direction_to(referencia_jogador.global_position)
	var distancia_ataque = global_position.distance_to(referencia_jogador.global_position)
	if distancia_ataque < 15 and pode_atacar:
		atacar()
	velocity = direcao * MOVE_SPEED
	move_and_slide()
	
func atacar():
	if referencia_jogador.vida == 0:
		return
	pode_atacar = false
	velocity = Vector2.ZERO
	referencia_jogador.levar_dano(dano)
	await get_tree().create_timer(1.0).timeout
	pode_atacar = true

func animar():
	if velocity.x < 0:
		animacao.flip_h = true
		
	if velocity.x > 0:
		animacao.flip_h = false
		
	if referencia_jogador != null:
		animacao.play("Correndo")
	else:
		animacao.play("Parado")

func _ao_entrar_na_area_deteccao(body):
	if body.is_in_group("jogador"):
		referencia_jogador = body


func _ao_sair_na_area_deteccao(body):
	if body.is_in_group("jogador"):
		referencia_jogador = null
		
func levar_dano(dano):
	vida -= dano
	notificar_dano()
	if vida <= 0:
		queue_free()

func notificar_dano():
	animacao.modulate = "#c40000"
	await get_tree().create_timer(0.2).timeout
	animacao.modulate = "#ffffff"
