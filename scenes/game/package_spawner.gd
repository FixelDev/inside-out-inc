class_name PackageSpawner extends Node2D

@export var packages_scenes: Array[PackedScene] = []
@export var aliens_scenes: Array[PackedScene] = []
@export var package_spawn_point: Marker2D

var current_package: Package

func spawn_package() -> void:
	var package_type: String = randomize_package_type()
	var package_scene: PackedScene
	
	if package_type == Globals.ALIEN_PACKAGE:
		package_scene = aliens_scenes.pick_random()
	else:
		package_scene = packages_scenes.pick_random()
	
	current_package = package_scene.instantiate()
	current_package.init_package(package_type)
	package_spawn_point.add_child(current_package)
	current_package.global_position = package_spawn_point.global_position


func randomize_package_type() -> String:
	var package_type: String = ""
	
	if is_package_normal():
		package_type = Globals.NORMAL_PACKAGE
	else:
		package_type = Globals.get_dictionary_key_based_on_odds(DayManager.current_day.evil_package_odds)
	
	return package_type


func is_package_normal() -> bool:
	return Globals.get_dictionary_key_based_on_odds(DayManager.current_day.package_type_odds) == Globals.NORMAL_PACKAGE


func destroy_current_package() -> void:
	current_package.queue_free()
