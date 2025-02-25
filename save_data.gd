extends Node

var config : ConfigFile;

func guardar_nivel_completado(numero:int):
	var config = ConfigFile.new()
	# Cargar fichero guardado.
	if config.load("user://configfile.cfg") != OK:
		# Crear fichero de guardado.
		config.save("user://configfile.cfg")
	config.set_value("niveles", "level_" + str(numero)+ "_completed", true)
	#config.set_value("seccion", "clave", "valor")
	
func comprobar_nivel_compleado(numero:int):
	var config = ConfigFile.new()
	if config.load("user://configfile.cfg") != OK:
		return
	var completed = config.get_value("niveles", "level_" + str(numero) + "_completed")
	
	
		
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
