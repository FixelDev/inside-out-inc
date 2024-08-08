extends Node2D


func _on_continue_button_pressed():
	SceneManager.load_scene(SceneManager.galactic_bulletin_scene)


func _on_new_game_button_pressed():
	DayManager.current_day_index = 0
	Globals.coins = 0
	SceneManager.load_scene(SceneManager.galactic_bulletin_scene)
