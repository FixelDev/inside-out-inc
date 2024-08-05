extends Node2D


func load_scene(scene_to_load: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene_to_load)
