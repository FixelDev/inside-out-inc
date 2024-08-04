class_name EmergencyModule extends Control

@export var emergency_code_label: Label
@export var emergency_keypad: EmergencyKeypad
@export var emergency_keypad_panel: EmergencyKeypadPanel

signal emergency_code_checked(is_correct: bool)

var emergency_code: int


func _ready() -> void:
	emergency_code = randi_range(1000, 9999)
	emergency_code_label.text = str(emergency_code)


func _on_emergency_keypad_panel_code_submited(code):
	emergency_code_checked.emit(code == str(emergency_code))


func _on_emergency_keypad_pressed():
	emergency_keypad_panel.show()


func _on_game_emergency_mode_toggled(enabled):
	emergency_keypad.disabled = !enabled
