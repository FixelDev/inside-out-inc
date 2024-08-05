extends Node2D


@export var emergency_button: Button
@export var accept_button: Button

@onready var timer_to_spawn_package: Timer = %TimerToSpawnPackage
@onready var time_left_progress_bar: TimeLeftProgressBar = %TimeLeftProgressBar
@onready var package_spawner = %PackageSpawner

signal emergency_mode_toggled(enabled: bool)


func _ready() -> void:
	init_stats()
	spawn_package()
	

func init_stats() -> void:
	Globals.packages_count = DayManager.current_day.packages_amount
	Globals.packages_current_count = 0
	Globals.strikes_count = DayManager.current_day.strikes_amount
	Globals.strikes_current_count = 0


func _process(delta) -> void:
	pass


func spawn_package() -> void:
	if Globals.packages_current_count >= Globals.packages_count:
		DayManager.increase_day()
		SceneManager.load_scene(SceneManager.galactic_bulletin_scene)
		return
	
	toggle_buttons(true)
	package_spawner.spawn_package()
	
	time_left_progress_bar.start_timer(10.0, time_left_progress_bar.TimerType.NORMAL)
	Globals.packages_current_count += 1

func _on_emergency_button_pressed():
	toggle_buttons(false)
	emergency_mode_toggled.emit(true)
	time_left_progress_bar.start_timer(7.0, time_left_progress_bar.TimerType.EMERGENCY)


func _on_accept_button_pressed():
	toggle_buttons(false)
	destroy_package()
	time_left_progress_bar.stop_timer()
	
	if package_spawner.current_package.is_evil():
		strike()
	else:
		give_coins(5)
	

func give_coins(amount: int) -> void:
	Globals.coins += amount


func strike() -> void:
	Globals.strikes_current_count += 1
	
	if Globals.strikes_current_count >= Globals.strikes_count:
		SceneManager.load_scene(SceneManager.game_over_scene)

func destroy_package() -> void:
	package_spawner.current_package.queue_free()
	
	timer_to_spawn_package.start()


func _on_emergency_module_emergency_code_checked(is_correct):
	if not is_correct:
		return
	
	time_left_progress_bar.stop_timer()
	emergency_mode_toggled.emit(false)
	destroy_package()
	
	if package_spawner.current_package.is_evil():
		give_coins(5)
	else:
		strike()


func _on_timer_to_spawn_package_timeout():
	spawn_package()


func _on_timer_extra_time_timeout():
	toggle_buttons(false)
	strike()
	emergency_mode_toggled.emit(false)
	#ADD CORRECT PACKAGE BEHAVIOUR
	
	destroy_package()


func toggle_buttons(enabled: bool) -> void:
	accept_button.disabled = !enabled
	emergency_button.disabled = !enabled
