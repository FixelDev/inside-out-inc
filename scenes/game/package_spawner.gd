class_name PackageSpawner extends Node2D

@export var packages_scenes: Array[PackedScene] = []
@export var aliens_scenes: Array[PackedScene] = []
@export var package_spawn_point: Marker2D

var current_package: Package

func spawn_package() -> void:
	var package_scene: PackedScene = packages_scenes.pick_random()
	current_package = package_scene.instantiate()
	package_spawn_point.add_child(current_package)
	current_package.global_position = package_spawn_point.global_position


func destroy_current_package() -> void:
	current_package.queue_free()
