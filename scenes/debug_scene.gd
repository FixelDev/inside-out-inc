extends Node2D

func _ready() -> void:
	for i in range(30):		
		print(str(i) + " " + Globals.get_dictionary_key_based_on_odds(DayManager.current_day.evil_package_odds))
