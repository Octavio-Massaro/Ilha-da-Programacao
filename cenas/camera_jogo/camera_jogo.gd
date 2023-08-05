extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = global_position.lerp(posicao_atual(), 1.0 - exp(-delta * 10))
	

func posicao_atual():
	var node_jogador = get_tree().get_first_node_in_group("jogador") as Node2D
	return node_jogador.global_position
	
