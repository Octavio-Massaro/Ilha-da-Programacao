extends CharacterBody2D

const TEMPLATE_AUDIO: PackedScene = preload("res://cenas/templateAudio/template_audio.tscn")

var referencia_jogador = null
var MOVE_SPEED = 100
var vida: int = 80
var dano: int = 20
var pode_atacar: bool = true

@onready var barra_vida: ProgressBar = get_node("BarraVida")
@onready var animacao: AnimationPlayer = get_node("Animacao")
@onready var textura: Sprite2D = get_node("Textura")

	
func _physics_process(_delta):
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
	criarEfeitoSonoro("res://characters/sons/17_orc_atk_sword_1.wav")
	pode_atacar = false
	referencia_jogador.levar_dano(dano)
	await get_tree().create_timer(1.0).timeout
	pode_atacar = true

func animar():
	if vida <= 0:
		set_physics_process(false)
		animacao.play("morte")
		criarEfeitoSonoro("res://characters/sons/24_orc_death_spin.wav")
		return
	if velocity.x < 0:
		textura.flip_h = true
		
	if velocity.x > 0:
		textura.flip_h = false
		
	if velocity != Vector2.ZERO:
		animacao.play("andando")
	else:
		animacao.play("parado")

func _ao_entrar_na_area_deteccao(body):
	if body.is_in_group("jogador"):
		referencia_jogador = body


func _ao_sair_na_area_deteccao(body):
	if body.is_in_group("jogador"):
		referencia_jogador = null
		
func levar_dano(dano):
	vida -= dano
	notificar_dano()

func notificar_dano():
	criarEfeitoSonoro("res://characters/sons/21_orc_damage_1.wav")
	textura.modulate = "#c40000"
	await get_tree().create_timer(0.2).timeout
	textura.modulate = "#ffffff"
	
func atualizar_barra_vida():
	barra_vida.value = vida

func _ao_terminar_animacao(anim_name):
	if anim_name == "morte":
		get_tree().call_group("missao","contabilizar_inimigos_derrotados")
		queue_free()

func criarEfeitoSonoro(caminhoAudio:String):
	var audio = TEMPLATE_AUDIO.instantiate()
	audio.efeitoSonoro = caminhoAudio
	add_child(audio)
