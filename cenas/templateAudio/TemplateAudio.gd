extends AudioStreamPlayer2D

var efeitoSonoro: String = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	stream = load(efeitoSonoro)
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func ao_terminar_timer():
	queue_free()
