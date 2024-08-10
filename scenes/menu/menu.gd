extends Node2D

@onready var button_pressed_audio_stream = %ButtonPressedAudioStream

func _on_continue_button_pressed():
	button_pressed_audio_stream.play()
	SceneManager.load_scene(SceneManager.galactic_bulletin_scene)


func _on_new_game_button_pressed():
	button_pressed_audio_stream.play()
	DayManager.current_day_index = 0
	Globals.coins = 0
	SceneManager.load_scene(SceneManager.galactic_bulletin_scene)
