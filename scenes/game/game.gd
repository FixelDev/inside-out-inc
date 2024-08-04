extends Node2D

@export var packages_scenes: Array[PackedScene] = []
@export var package_spawn_point: Marker2D
@export var emergency_button: Button
@export var accept_button: Button

@onready var timer_to_spawn_package: Timer = %TimerToSpawnPackage
@onready var time_left_progress_bar: TimeLeftProgressBar = %TimeLeftProgressBar

signal emergency_mode_toggled(enabled: bool)

var current_package: Package


func _ready() -> void:
	spawn_package()

func _process(delta) -> void:
	pass


func spawn_package() -> void:
	toggle_buttons(true)
	var package_scene: PackedScene = packages_scenes.pick_random()
	current_package = package_scene.instantiate()
	add_child(current_package)
	current_package.global_position = package_spawn_point.global_position
	
	print(current_package.is_evil())
	time_left_progress_bar.start_timer(10.0)


func _on_emergency_button_pressed():
	toggle_buttons(false)
	emergency_mode_toggled.emit(true)
	time_left_progress_bar.start_timer(7.0)


func _on_accept_button_pressed():
	toggle_buttons(false)
	destroy_package()
	time_left_progress_bar.stop_timer()
	
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
	
	time_left_progress_bar.stop_timer()
	emergency_mode_toggled.emit(false)
	destroy_package()
	
	if current_package.is_evil():
		print("COINS")
	else:
		print("STRIKE")


func _on_timer_to_spawn_package_timeout():
	spawn_package()


func _on_timer_extra_time_timeout():
	toggle_buttons(false)
	print("STRIKE")
	#ADD CORRECT PACKAGE BEHAVIOUR
	
	destroy_package()


func toggle_buttons(enabled: bool) -> void:
	accept_button.disabled = !enabled
	emergency_button.disabled = !enabled
