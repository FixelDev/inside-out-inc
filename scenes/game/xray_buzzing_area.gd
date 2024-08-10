extends Area2D

@onready var xray = %Xray
@onready var xray_audio_stream = %XrayAudioStream

var is_mouse_in_area: bool = false

func _process(delta):
	#if is_mouse_in_area and xray.visible and not xray_audio_stream.playing:
		#xray_audio_stream.play()
	#elif (not is_mouse_in_area or not xray.visible) and xray_audio_stream.playing:
		#xray_audio_stream.stop()
		
	pass	

func _on_mouse_entered():
	is_mouse_in_area = true


func _on_mouse_exited():
	is_mouse_in_area = false
