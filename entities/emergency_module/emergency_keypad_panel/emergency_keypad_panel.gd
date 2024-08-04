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
		generate_number_button(str(i))
		
	generate_dummy_button()
	generate_number_button("0")
	generate_dummy_button()

func generate_dummy_button() -> void:
	var number_button: Button = number_button_scene.instantiate()
	number_buttons_container.add_child(number_button)
	number_button.modulate = Color.TRANSPARENT


func generate_number_button(number: String) -> void:
	var number_button: Button = number_button_scene.instantiate()
	number_button.text = number
	number_buttons_container.add_child(number_button)
	number_button.pressed.connect(_on_number_button_pressed.bind(number))


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


func _on_emergency_module_emergency_code_checked(is_correct):
	if is_correct:
		show_on_display("CORRECT")
		var close_timer = get_tree().create_timer(2)
		close_timer.timeout.connect(hide)
		
	else:
		show_on_display("INCORRECT")
