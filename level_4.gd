extends Node3D

@export var NEXT_LEVEL : PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_fall_detection_area_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()
		
func _on_goal_area_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_packed(NEXT_LEVEL)
