extends Node2D

@export var game_scene: PackedScene
@export var menu_scene: PackedScene


func _on_reset_day_button_pressed():
	SceneManager.load_scene(game_scene)


func _on_menu_button_pressed():
	SceneManager.load_scene(menu_scene)
