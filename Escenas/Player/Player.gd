extends Area2D

signal colectado
signal atrapado

var posic = Vector2(240, 352)
var movimiento = Vector2()

const VELOCIDAD = 150


func _ready():
	OS.center_window()
	set_position(posic)
	pass


func _process(delta):
	SF_direccion()
	SF_animar()
	posic.x = clamp(posic.x, 50, 430)
	posic.y = clamp(posic.y, 95, 605)
	posic += movimiento * VELOCIDAD * delta
	set_position(posic)
	pass


func SF_direccion():
	movimiento = Vector2()
	if Input.is_action_pressed("ui_left"):
		movimiento.x = -1
	if Input.is_action_pressed("ui_right"):
		movimiento.x = 1
	if Input.is_action_pressed("ui_up"):
		movimiento.y = -1
	if Input.is_action_pressed("ui_down"):
		movimiento.y = 1
	movimiento = movimiento.normalized()
	pass


func SF_animar():
	if movimiento.x > 0:
		$DibujoRobot.set_flip_h(true)
	if movimiento.x < 0:
		$DibujoRobot.set_flip_h(false)
	if movimiento.length() == 0:
		$DibujoRobot.set_animation("Idle")
	if movimiento.length() != 0:
		$DibujoRobot.set_animation("Run")
	pass


func _on_Player_area_entered(area):
	if area.is_in_group("Engrane"):
		area.SF_encontrado()
		emit_signal("colectado")
	if area.is_in_group("Enemigo"):
		emit_signal("atrapado")
	pass


func SF_gameover_player():
	set_process(false)
	$DibujoRobot.set_animation("Hurt")
	pass
