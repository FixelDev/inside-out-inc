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
