extends Panel

@onready var day_label = %DayLabel


func _ready() -> void:
	day_label.text = "Day " + str(DayManager.current_day.number)
