extends CharacterBody2D

@onready var animacao: AnimatedSprite2D = get_node("Animacao")
var pode_interagir: bool = false
var dialogo_aberto: bool = false
var congelar: bool = true
@export_category("Objects")
@export var jogador: CharacterBody2D = null
# Called when the node enters the scene tree for the first time.
func _ready():
	animacao.play("parado")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if pode_interagir and Input.is_action_just_pressed("interagir"):
		pode_interagir = false	
		jogador.set_physics_process(false)
		DialogueManager.show_example_dialogue_balloon(load(VariaveisGlobais.dialogo_atual))
	if VariaveisGlobais.fim_dialogo:
		VariaveisGlobais.fim_dialogo = false
		jogador.set_physics_process(true)
		
func _ao_entra_da_area_dialogo(body):	
	if body.name == "Jogador":
		pode_interagir = true

func _ao_sair_da_area_dialogo(body):
	if body.name == "Jogador":
		pode_interagir = false

