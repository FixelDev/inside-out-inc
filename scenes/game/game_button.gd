extends Button

@export var audio_listener: AudioStreamPlayer2D


func _on_pressed():
	audio_listener.play()
