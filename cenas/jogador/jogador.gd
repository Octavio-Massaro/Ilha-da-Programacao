extends CharacterBody2D

@export_category("Variaveis")
@export var velocidade_movimento: float = 150
@export var vida: int = 100
@export var dano: int = 20
@export_category("Nós")
@export var _animation_tree: AnimationTree = null
@onready var temporizador_ataque: Timer = get_node("TempoAtaque")
@onready var textura: Sprite2D = get_node("Textura")
@onready var barra_vida: ProgressBar = get_node("BarraVida")

const TEMPLATE_AUDIO: PackedScene = preload("res://cenas/templateAudio/template_audio.tscn")
var maquina_estado
var esta_atacando: bool = false
var esta_morto = false
var vida_maxima: int

func _ready():
	vida_maxima = vida
	barra_vida.max_value = vida_maxima
	maquina_estado = _animation_tree["parameters/playback"]

func _physics_process(_delta):
	if !esta_morto:
		atualizar_barra_vida()
		atacar()
		movimentar()
		animar()	
		
func movimentar():
	var direcao: Vector2 = Vector2(
		Input.get_axis("mover_esquerda","mover_direita"),
		Input.get_axis("mover_baixo","mover_cima")
	)
	
	if direcao != Vector2.ZERO:
		_animation_tree["parameters/parado/blend_position"] = direcao
		_animation_tree["parameters/andando/blend_position"] = direcao
		_animation_tree["parameters/atacando/blend_position"] = direcao
	
	velocity = direcao.normalized() * velocidade_movimento
	
	move_and_slide()

func animar():
	if esta_atacando:
		maquina_estado.travel("atacando")
		return
		
	if velocity != Vector2.ZERO:
		maquina_estado.travel("andando")
		return
	maquina_estado.travel("parado")
	
func atacar():
	if Input.is_action_just_pressed("ataque") and !esta_atacando:
		criarEfeitoSonoro("res://characters/sons/07_human_atk_sword_2.wav")
		set_physics_process(false)
		temporizador_ataque.start()
		esta_atacando = true
		
func _quando_tempo_ataque_acabar():
	esta_atacando = false
	set_physics_process(true)
	
func _ao_entrar_na_area_ataque(body):
	if body.is_in_group("inimigo"):
		body.levar_dano(dano)
	
func levar_dano(dano):
	vida -= dano
	notificar_dano()
	if vida <= 0:
		barra_vida.value = 0
		esta_morto = true
		maquina_estado.travel("morte")
		criarEfeitoSonoro("res://characters/sons/14_human_death_spin.wav")
		await get_tree().create_timer(0.8).timeout
		get_tree().reload_current_scene()
		
func notificar_dano():
	criarEfeitoSonoro("res://characters/sons/11_human_damage_3.wav")
	textura.modulate = "#c40000"
	await get_tree().create_timer(0.2).timeout
	textura.modulate = "#ffffff"
	
func atualizar_barra_vida():
	barra_vida.value = vida
	
	if vida >= vida_maxima:
		barra_vida.visible = false
	else:
		barra_vida.visible = true
	
func regenerar_vida():
	if vida < vida_maxima:
		vida += 10
		if vida > vida_maxima:
			vida = vida_maxima	
		if vida < 0:
			vida = 0
			
func quando_tempo_regeneracao_acabar():
	regenerar_vida()
	
func criarEfeitoSonoro(caminhoAudio:String):
	var audio = TEMPLATE_AUDIO.instantiate()
	audio.efeitoSonoro = caminhoAudio
	add_child(audio)
