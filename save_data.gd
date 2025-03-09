extends Node

var config : ConfigFile;
const savePath = "user://configfile.cfg"

func _ready() -> void :
	config = ConfigFile.new()
	# Cargar fichero guardado.
	if config.load(savePath) != OK:
		if config.save(savePath) == OK:
			print("Se creo el fichero para guardar niveles: " + savePath)
		else:
			print("Error al crear el fichero de guardar niveles")		
	
func guardar_nivel_completado(numero:int):
	config.set_value("pased", "level_" + str(numero), true)
	var result = config.save(savePath)
	if result == OK:
		print("Nivel numero: " + str(numero) + " guardado correctamente.")
	else:
		print("No se ha guardado el nivel numero: " + str(numero) + ".")
	
	
func nivel_completado(numero:int):
	return config.get_value("pased", "level_" + str(numero), false)
	
func borrar_progreso():
	config.erase_section("pased")
	config.save(savePath)
	
	
	#var config = ConfigFile.new()
	#if config.load("user://configfile.cfg") != OK:
	#	return
	#var completed = config.get_value("niveles", "level_" + str(numero) + "_completed")
	#config.set_value("niveles", "level_" + str(numero)+ "_completed", true)
	#	config.save("user://configfile.cfg")
