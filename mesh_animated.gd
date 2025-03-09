extends Node3D

@export var punto_inicial: Marker3D
@export var punto_final: Marker3D
@export var duracion_movimiento: float = 4.0
@export var plataforma_personalizada: GridMap

var animacion_actual: Tween

func _ready() -> void:
	# Asignar marcadores predeterminados si no se especificaron
	punto_inicial = punto_inicial if punto_inicial else $initial_position
	punto_final = punto_final if punto_final else $final_position
	
	# Gestionar la plataforma
	if plataforma_personalizada:
		$mesh_floor.queue_free()
	else:
		plataforma_personalizada = $mesh_floor
	
	# Iniciar movimiento
	iniciar_movimiento_ciclico()

func iniciar_movimiento_ciclico() -> void:
	if !punto_inicial or !punto_final:
		push_error("No se encontraron los puntos de referencia para el movimiento")
		return
	
	# Establecer posición inicial
	position = to_global(punto_inicial.position)
	
	# Crear animación
	animacion_actual = get_tree().create_tween()
	animacion_actual.set_loops()
	
	# Configurar el recorrido de ida y vuelta
	var ida = animacion_actual.tween_property(
		self, 
		"position", 
		to_global(punto_final.position), 
		duracion_movimiento
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	var vuelta = animacion_actual.tween_property(
		self, 
		"position", 
		to_global(punto_inicial.position), 
		duracion_movimiento
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

func _exit_tree() -> void:
	if animacion_actual and animacion_actual.is_valid():
		animacion_actual.kill()
