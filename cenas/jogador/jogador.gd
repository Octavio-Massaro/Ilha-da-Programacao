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

var _state_machine
var esta_atacando: bool = false
var esta_morto = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_state_machine = _animation_tree["parameters/playback"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(_delta)-> void:
	if !esta_morto:
		atualizar_barra_vida()
		atacar()
		movimentar()
		animar()	
	
	

func movimentar() -> void:
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

func animar() -> void:
	if esta_atacando:
		_state_machine.travel("atacando")
		return
		
	if velocity != Vector2.ZERO:
		_state_machine.travel("andando")
		return
	_state_machine.travel("parado")
	
func atacar() -> void:
	if Input.is_action_just_pressed("ataque") and !esta_atacando:
		set_physics_process(false)
		temporizador_ataque.start()
		esta_atacando = true
		

func _quando_tempo_ataque_acabar() -> void:
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
		_state_machine.travel("morte")
		await get_tree().create_timer(0.8).timeout
		get_tree().reload_current_scene()
		
func notificar_dano():
	textura.modulate = "#c40000"
	await get_tree().create_timer(0.2).timeout
	textura.modulate = "#ffffff"
	
func atualizar_barra_vida() -> void:
	barra_vida.value = vida
	
	if vida == 100:
		barra_vida.visible = false
	else:
		barra_vida.visible = true
	
func regenerar_vida() -> void:
	if vida < 100:
		
		vida += 10
		if vida > 100:
			vida = 100
		if vida < 0:
			vida = 0
			

func quando_tempo_regeneracao_acabar():
	regenerar_vida()
