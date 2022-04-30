extends Area2D

var posic = Vector2(100, 100)
var movimiento = Vector2()

const VELOCIDAD = 150

func _ready():
	OS.center_window()
	set_position(posic)
	pass


func _process(delta):
	SF_animar()
	posic += movimiento * VELOCIDAD * delta
#	posic.x = clamp(posic.x, 50, 430)
#	posic.y = clamp(posic.y, 50, 650)
#	if posic.x < 50:
#		movimiento.x = movimiento.x * (-1)
#	if posic.x > 430:
#		movimiento.x = movimiento.x * (-1)
	# Es más entendible escribir:
	if (posic.x < 50) or (posic.x > 430):
		movimiento.x *= -1
	if (posic.y < 50) or (posic.y > 650):
		movimiento.y *= -1
	set_position(posic)
	pass


func SF_dirigir_enemigo(posic_player):
	# La dirección va a estar dada por:
	# posición del player - posición del enemigo.
	# posición del enemigo = posic
	# posición del player me la manda Ppal y es posic_player
	movimiento = posic_player - posic
	movimiento = movimiento.normalized()
	pass


func SF_animar():
	if movimiento.x < 0:
		$Animated.set_flip_h(true)
	if movimiento.x > 0:
		$Animated.set_flip_h(false)
	pass

func SF_gameover_enemigo():
	set_process(false)
	pass
