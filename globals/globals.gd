extends Node

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
