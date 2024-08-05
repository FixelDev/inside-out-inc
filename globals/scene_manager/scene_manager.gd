extends Node2D

@export var game_scene: PackedScene
@export var menu_scene: PackedScene
@export var galactic_bulletin_scene: PackedScene
@export var game_over_scene: PackedScene

func load_scene(scene_to_load: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene_to_load)
