extends Node2D

@export var packages_scenes: Array[PackedScene] = []
@export var package_spawn_point: Marker2D
@export var emergency_crate: EmergencyCrate

var current_package: Package


func _ready() -> void:
	spawn_package()


func spawn_package() -> void:
	var package_scene: PackedScene = packages_scenes.pick_random()
	current_package = package_scene.instantiate()
	add_child(current_package)
	current_package.global_position = package_spawn_point.global_position


func _on_emergency_button_pressed():
	enable_emergency_mode()
	

func _on_accept_button_pressed():
	destroy_package()
	
	if current_package.is_evil():
		print("STRIKE")
	else:
		print("COINS")
	

func destroy_package() -> void:
	current_package.queue_free()


func enable_emergency_mode() -> void:
	emergency_crate.close()
