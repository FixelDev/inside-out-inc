extends Node2D

@export var packages_scenes: Array[PackedScene] = []
@export var package_spawn_point: Marker2D

@onready var timer_to_spawn_package = %TimerToSpawnPackage

signal emergency_mode_toggled(enabled: bool)

var current_package: Package


func _ready() -> void:
	spawn_package()


func spawn_package() -> void:
	var package_scene: PackedScene = packages_scenes.pick_random()
	current_package = package_scene.instantiate()
	add_child(current_package)
	current_package.global_position = package_spawn_point.global_position
	
	print(current_package.is_evil())


func _on_emergency_button_pressed():
	emergency_mode_toggled.emit(true)
	

func _on_accept_button_pressed():
	destroy_package()
	
	if current_package.is_evil():
		print("STRIKE")
	else:
		print("COINS")
	

func destroy_package() -> void:
	current_package.queue_free()
	
	timer_to_spawn_package.start()


func _on_emergency_module_emergency_code_checked(is_correct):
	if not is_correct:
		return
	
	emergency_mode_toggled.emit(false)
	destroy_package()
	
	if current_package.is_evil():
		print("COINS")
	else:
		print("STRIKE")


func _on_timer_to_spawn_package_timeout():
	spawn_package()
