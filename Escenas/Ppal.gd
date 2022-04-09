extends Node2D
# Alumnos:
# Día:
# Proyecto:


var engranes_inic = 5
var puntos = 0
var level = 0
var tiempo = 10

export (PackedScene) var Engrane

func _ready():
	OS.center_window()
	randomize()
	SF_instanciar_engranes()
	SF_actualizar_interfaz()
	pass


#func _process(delta):
#	pass


func SF_instanciar_engranes():
	for cantidad in range(engranes_inic + level):
		var EngranePreparado = Engrane.instance()
		EngranePreparado.set_position(Vector2((randi()%11 * 40) + 40, rand_range(40, 664)))
		$ContenedorEngranes.call_deferred("add_child", EngranePreparado)
	pass


func _on_Player_colectado():
	puntos += 1
	if $ContenedorEngranes.get_child_count() == 1:
		SF_levelup()
	SF_actualizar_interfaz()
	pass


func SF_actualizar_interfaz():
	$Interfaz/Puntos.set_text(str(puntos))
	$Interfaz/Nivel.set_text(str(level))
	$Interfaz/Tiempo.set_text(str(tiempo))
	pass


func _on_TimerMensaje_timeout():
	$Interfaz/Mensaje.set_visible(false)
	pass


func _on_TimerPpal_timeout():
	tiempo -= 1
	SF_actualizar_interfaz()
	if $ContenedorEngranes.get_child_count() == 0:
		SF_levelup()
	if tiempo == 0:
		SF_gameover()
	pass


func SF_levelup():
	level += 1
	$Interfaz/Mensaje.set_text("Level Up !!!")
	$Interfaz/Mensaje.set_visible(true)
	$ContenedorTimers/TimerMensaje.start()
	SF_instanciar_engranes()
	tiempo = 10
	pass


func SF_gameover():
	# El tiempo se pare.  Hecho
	$ContenedorTimers/TimerPpal.stop()
	# Qué el jugador deje de moverse y que reproduzca Hurt. Hecho
	$Player.SF_gameover_player()
	# Qué te resalte los puntos. Hecho
	$Interfaz/Puntos.set_scale(Vector2(2, 2))
	# Mostrar cartel de Game Over. Hecho
	$Interfaz/Mensaje.set_text("Game Over !!!")
	$Interfaz/Mensaje.set_visible(true)
	# Manera de reiniciar el juego. Hecho
	$Interfaz/Button.set_visible(true)
	pass


func _on_Button_pressed():
	get_tree().reload_current_scene()
	pass


func _on_TimerEnemigo_timeout():
	var posic_player = $Player.get_position()
	$Enemigo.SF_dirigir_enemigo(posic_player)
	pass


func _on_Player_atrapado():
	SF_gameover()
	pass
