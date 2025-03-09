extends Node

@export var save_data: Node;

func _ready() -> void:
	if save_data == null:
		save_data = $Save_Data

func _process(delta: float) -> void:
	pass
