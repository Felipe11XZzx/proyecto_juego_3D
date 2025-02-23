extends Node3D

@export var LEVEL_1_SCENE: PackedScene
@export var LEVEL_2_SCENE: PackedScene
@export var LEVEL_3_SCENE: PackedScene

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_fall_detection_area_body_entered(body):
	get_tree().reload_current_scene()


func _on_level_area_1_body_entered(body: Node3D) -> void:
	print("Entrando en el nivel 1.")
	get_tree().change_scene_to_packed(LEVEL_1_SCENE)
	

func _on_level_area_2_body_entered(body: Node3D) -> void:
	print("Entrando en el nivel 2.")
	get_tree().change_scene_to_packed(LEVEL_2_SCENE)
	
	
func _on_level_area_3_body_entered(body: Node3D) -> void:
	print("Entrando en el nivel 3.")
	get_tree().change_scene_to_packed(LEVEL_3_SCENE)
