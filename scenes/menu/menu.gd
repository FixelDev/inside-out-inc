extends Node2D

@onready var button_pressed_audio_stream = %ButtonPressedAudioStream
@onready var continue_button = %ContinueButton

func _on_continue_button_pressed():
	button_pressed_audio_stream.play()
	SceneManager.load_scene(SceneManager.galactic_bulletin_scene)


func _on_new_game_button_pressed():
	button_pressed_audio_stream.play()
	DayManager.current_day_index = 0
	Globals.coins = 0
	SceneManager.load_scene(SceneManager.galactic_bulletin_scene)


func _on_continue_button_mouse_entered():
	continue_button.text = "Day " + str(DayManager.current_day.number)


func _on_continue_button_mouse_exited():
	continue_button.text = "Continue"
