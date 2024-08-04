class_name EmergencyKeypadPanel extends Panel

@export var number_button_scene: PackedScene

@onready var entered_code_label = %EnteredCodeLabel
@onready var number_buttons_container = %NumberButtonsContainer

signal code_submited(code: String)

var entered_code: String

func _ready() -> void:
	generate_number_buttons()
	
	
func generate_number_buttons() -> void:
	for i in range(1, 10):
		var number_button: Button = number_button_scene.instantiate()
		number_button.text = str(i)
		number_buttons_container.add_child(number_button)
		number_button.pressed.connect(_on_number_button_pressed.bind(str(i)))


func _on_number_button_pressed(number: String) -> void:
	if entered_code.length() > 6:
		return
	
	entered_code += number
	update_display()


func update_display() -> void:
	entered_code_label.text = entered_code


func show_on_display(message: String) -> void:
	entered_code_label.text = message
	entered_code = ""


func _on_reset_button_pressed():
	entered_code = ""
	update_display()
	

func _on_accept_button_pressed():
	code_submited.emit(entered_code)
