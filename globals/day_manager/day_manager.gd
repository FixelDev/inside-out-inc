extends Node2D

@export var days: Array[Day] = []

var current_day: Day
var current_day_index = 0

func _ready() -> void:
	current_day = days[current_day_index]
	
	
func increase_day() -> void:
	current_day_index += 1
	
	current_day = days[current_day_index]


func is_last_day() -> bool:
	return current_day.number == days.size()
