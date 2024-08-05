extends Node

const NORMAL_PACKAGE: String = "normal_package"
const EVIL_PACKAGE: String = "evil_package"

const ALIEN_PACKAGE: String = "alien_package"
const ALIEN_IN_PACKAGE: String = "alien_in_package"
const ALIEN_PARTS_IN_PACKAGE: String = "alien_parts_in_package"
const ALIEN_PARTS_IN_PACKAGE_TIMER: String = "alien_parts_in_package_timer"

const ALIEN_PARTS_EASY: String = "alien_parts_easy"
const ALIEN_PARTS_MEDIUM: String = "alien_parts_medium"
const ALIEN_PARTS_HARD: String = "alien_parts_hard"

signal stats_changed()

var packages_count: int: 
	set(value):
		packages_count = value
		stats_changed.emit()
	get:
		return packages_count

var packages_current_count: int:
	set(value):
		packages_current_count = value
		stats_changed.emit()
	get:
		return packages_current_count
		
var strikes_count: int:
	set(value):
		strikes_count = value
		stats_changed.emit()
	get:
		return strikes_count
		
var strikes_current_count: int:
	set(value):
		strikes_current_count = value
		stats_changed.emit()
	get:
		return strikes_current_count
		
var coins: int = 0:
	set(value):
		coins = value
		stats_changed.emit()
	get:
		return coins


func get_dictionary_key_based_on_odds(dictionary_odds: Dictionary) -> String:
	var successful_keys_dict: Dictionary
	var successful_values_dict: Dictionary
	
	var index = 0
	
	for key in dictionary_odds.keys():
		var random_value: float = randf_range(0.01, 1)
		
		if random_value <= dictionary_odds[key]:
			successful_keys_dict[index] = key
			successful_values_dict[index] = dictionary_odds[key]
			index += 1
	
	var dict_key: String
	
	if successful_keys_dict.keys().size() > 0:		
		var smallest_value_index: int = successful_values_dict.keys()[0]
		
		for key_index in successful_keys_dict.keys():
			if successful_values_dict[key_index] < successful_values_dict[smallest_value_index]:
				smallest_value_index = key_index
				
		dict_key = successful_keys_dict[smallest_value_index]
	else:
		var biggest_odds: float = dictionary_odds.values()[0]
		
		for key in dictionary_odds.keys():
			if dictionary_odds[key] >= biggest_odds:
				biggest_odds = dictionary_odds[key]
				dict_key = key
	
	return dict_key
