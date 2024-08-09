class_name EmergencyModule extends Control



@export var emergency_code_label: Label
@export var emergency_keypad: EmergencyKeypad
@export var emergency_keypad_panel: EmergencyKeypadPanel

@onready var red_light_panel_animator = %RedLightPanelAnimator
@onready var emergency_keypad_pressed_audio_stream = %EmergencyKeypadPressedAudioStream

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
	else:
		emergency_keypad_panel.hide()
		red_light_panel_animator.stop()


func randomize_code() -> void:
	emergency_code = randi_range(1000, 9999)
	emergency_code_label.text = str(emergency_code)


func _on_emergency_code_checked(is_correct):
	if is_correct:
		randomize_code()
