class_name EmergencyModule extends Control



@export var emergency_code_label: Label
@export var emergency_keypad: EmergencyKeypad
@export var emergency_keypad_panel: EmergencyKeypadPanel

@onready var red_light_panel_animator = %RedLightPanelAnimator
@onready var emergency_keypad_pressed_audio_stream = %EmergencyKeypadPressedAudioStream
@onready var music_audio_stream = %MusicAudioStream
@onready var emergency_music_audio_stream = %EmergencyMusicAudioStream

signal emergency_code_checked(is_correct: bool)

var emergency_code: int

func _ready() -> void:
	randomize_code()


func _on_emergency_keypad_panel_code_submited(code):
	emergency_code_checked.emit(code == str(emergency_code))


func _on_emergency_keypad_pressed():
	emergency_keypad_pressed_audio_stream.play()
	emergency_keypad_panel.show()
	emergency_keypad_panel.clear()


func _on_game_emergency_mode_toggled(enabled):
	emergency_keypad.disabled = !enabled
	
	
	if enabled:
		red_light_panel_animator.play("show")
		emergency_music_audio_stream.volume_db = 0
		emergency_music_audio_stream.play()
		music_audio_stream.volume_db = -20
	else:
		emergency_keypad_panel.hide()
		red_light_panel_animator.stop()
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(emergency_music_audio_stream, "volume_db", -30, 1.5)
		tween.set_parallel(true)
		tween.tween_property(music_audio_stream, "volume_db", -10, 1.5)
		await tween.finished
		
		emergency_music_audio_stream.stop()


func randomize_code() -> void:
	emergency_code = randi_range(1000, 9999)
	emergency_code_label.text = str(emergency_code)


func _on_emergency_code_checked(is_correct):
	if is_correct:
		randomize_code()
