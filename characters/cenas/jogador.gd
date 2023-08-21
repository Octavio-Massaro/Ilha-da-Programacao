extends CharacterBody2D

@export var velocidade_movimento: float = 200
@export_category("Objetos")
@export var _animation_tree: AnimationTree = null
@onready var temporizador_ataque: Timer = get_node("TempoAtaque")

var _state_machine
var esta_atacando: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	_state_machine = _animation_tree["parameters/playback"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(_delta)-> void:
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
	_state_machine.travel("andando")
	
func atacar() -> void:
	if Input.is_action_just_pressed("ataque") and !esta_atacando:
		set_physics_process(false)
		temporizador_ataque.start()
		esta_atacando = true
		
		


func _quando_tempo_ataque_acabar() -> void:
	esta_atacando = false
	set_physics_process(true)
	
