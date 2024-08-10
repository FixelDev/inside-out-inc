extends Node2D

@onready var button_audio_stream = %ButtonAudioStream


func _on_start_button_pressed():
	button_audio_stream.play()
	SceneManager.load_scene(SceneManager.game_scene)
