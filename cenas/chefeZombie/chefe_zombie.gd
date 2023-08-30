extends CharacterBody2D

var referencia_jogador = null
var MOVE_SPEED = 100
var vida: int = 60
var dano: int = 20
var pode_atacar: bool = true

@onready var barra_vida: ProgressBar = get_node("BarraVida")
@onready var animacao: AnimatedSprite2D = get_node("Animacao")

func _ready():
	pass 
	
func _physics_process(delta):
	atualizar_barra_vida()
	if referencia_jogador == null:
		velocity = Vector2.ZERO
		animar()
		return
		
	perseguir()
	
func perseguir():
	var direcao = global_position.direction_to(referencia_jogador.global_position)
	var distancia_ataque = global_position.distance_to(referencia_jogador.global_position)
	if distancia_ataque < 20:
		if pode_atacar:
			atacar()
		velocity = Vector2.ZERO
	else:
		velocity = direcao * MOVE_SPEED
	animar()
	move_and_slide()
	
func atacar():
	pode_atacar = false
	referencia_jogador.levar_dano(dano)
	await get_tree().create_timer(1.0).timeout
	pode_atacar = true

func animar():
	if velocity.x < 0:
		animacao.flip_h = true
		
	if velocity.x > 0:
		animacao.flip_h = false
		
	if velocity != Vector2.ZERO:
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
	
func atualizar_barra_vida():
	barra_vida.value = vida
	
	
