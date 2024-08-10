extends Node2D

@onready var button_pressed_autio_stream = %ButtonPressedAutioStream

func _on_reset_day_button_pressed():
	button_pressed_autio_stream.play()
	SceneManager.load_scene(SceneManager.game_scene)


func _on_menu_button_pressed():
	button_pressed_autio_stream.play()
	SceneManager.load_scene(SceneManager.menu_scene)
