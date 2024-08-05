class_name Day extends Resource

@export var number: int
@export var packages_amount: int
@export var strikes_amount: int

@export_group("Normal and evil packages percentage")
@export var normal_packages_percent: float
@export var evil_packages_percent: float

@export_group("Evil packages types percentage")
@export var alien_percent: float
@export var alien_in_package_percent: float
@export var alien_parts_in_package_percent: float
@export var alien_parts_in_package_timer_percent: float

@export_group("Alien parts difficulty")
@export var alien_parts_easy_percent: float
@export var alien_parts_medium_percent: float
@export var alien_parts_hard_percent: float
