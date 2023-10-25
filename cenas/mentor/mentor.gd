extends CharacterBody2D

var pode_interagir: bool = false
@export_category("Nós")
@export var jogador: CharacterBody2D = null
@onready var animacao: AnimatedSprite2D = get_node("Animacao")

func _ready():
	animacao.play("parado")

func _process(_delta):
	if pode_interagir and Input.is_action_just_pressed("interagir"):
		pode_interagir = false	
		jogador.set_physics_process(false)
		DialogueManager.show_dialogue_balloon(load(VariaveisGlobais.dialogo_atual))
	if VariaveisGlobais.fim_dialogo:
		VariaveisGlobais.fim_dialogo = false
		pode_interagir = true
		jogador.set_physics_process(true)
		
func _ao_entra_na_area_dialogo(body):	
	if body.name == "Jogador":
		pode_interagir = true

func _ao_sair_da_area_dialogo(body):
	if body.name == "Jogador":
		pode_interagir = false
