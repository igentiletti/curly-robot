extends Area2D


var posic = Vector2()


func _ready():
	SF_inicio()
	randomize()
	pass # Replace with function body.

#func _process(delta):
#
#	pass

func SF_posicionar():
	posic = Vector2((randi()%11 * 40) + 40, rand_range(40, 664))
	set_position(posic)
	pass


func _on_TimerBateria_timeout():
	SF_posicionar()
	pass # Replace with function body.

func SF_inicio():
	posic = Vector2(-20, -20)
	set_position(posic)
	pass

func SF_esperar_levelup():
	$TimerBateria.stop()
	pass
