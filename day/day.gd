class_name Day extends Resource

@export var number: int
@export var packages_amount: int
@export var strikes_amount: int
@export var normal_time_left: float
@export var emergency_time_left: float

@export var package_type_odds: Dictionary = {
	Globals.NORMAL_PACKAGE: 0.0,
	Globals.EVIL_PACKAGE: 0.0,
}

@export var evil_package_odds: Dictionary = {
	Globals.ALIEN_PACKAGE: 0.0,
	Globals.ALIEN_IN_PACKAGE: 0.0,
	Globals.ALIEN_PARTS_IN_PACKAGE: 0.0,
	Globals.ALIEN_PARTS_IN_PACKAGE_TIMER: 0.0,
}

@export var alien_parts_difficulty_odds: Dictionary = {
	Globals.ALIEN_PARTS_EASY: 0.0,
	Globals.ALIEN_PARTS_MEDIUM: 0.0,
	Globals.ALIEN_PARTS_HARD: 0.0,
}
