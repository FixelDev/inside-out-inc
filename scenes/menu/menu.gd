extends Node2D

@export var game_scene: PackedScene



func _on_play_button_pressed():
	SceneManager.load_scene(game_scene)
