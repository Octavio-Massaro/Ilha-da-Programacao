extends CharacterBody2D

@export_category("Variaveis")
@export var velocidade_movimento: float = 150
@export var vida: int = 10
@export_category("Nós")
@export var _animation_tree: AnimationTree = null
@onready var temporizador_ataque: Timer = get_node("TempoAtaque")

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
		movimentar()
		atacar()
		animacao()	
	
	

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

func animacao() -> void:
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
		body.levar_dano(1)
	
func levar_dano(dano):
	vida -= dano
	if vida <= 0:
		esta_morto = true
		_state_machine.travel("morte")
		await get_tree().create_timer(0.8).timeout
		get_tree().reload_current_scene()
		
