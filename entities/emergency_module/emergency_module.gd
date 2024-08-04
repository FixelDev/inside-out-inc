class_name EmergencyModule extends Control

@export var emergency_code_label: Label
@export var emergency_keypad: EmergencyKeypad
@export var emergency_keypad_panel: EmergencyKeypadPanel

var emergency_code: int


func _ready() -> void:
	emergency_code = randi_range(1000, 9999)
	emergency_code_label.text = str(emergency_code)


func _on_game_emergency_mode_enabled():
	emergency_keypad.disabled = false


func _on_emergency_keypad_panel_code_submited(code):
	if code == str(emergency_code):
		emergency_keypad_panel.show_on_display("CORRECT")
	else:
		emergency_keypad_panel.show_on_display("INCORRECT")


func _on_emergency_keypad_pressed():
	emergency_keypad_panel.show()
