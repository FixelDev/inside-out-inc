extends Node2D


@export var emergency_button: Button
@export var accept_button: Button

@onready var timer_to_spawn_package: Timer = %TimerToSpawnPackage
@onready var time_left_progress_bar: TimeLeftProgressBar = %TimeLeftProgressBar
@onready var package_spawner = %PackageSpawner
@onready var xray = %Xray
@onready var info_paper = %InfoPaper

signal emergency_mode_toggled(enabled: bool)


func _ready() -> void:
	toggle_buttons(false)
	init_stats()
	#var timer:SceneTreeTimer = get_tree().create_timer(1)
	#timer.timeout.connect(spawn_package)
	
	if DayManager.current_day.number > 1:
		spawn_package()
	else:
		info_paper.visible = true

func init_stats() -> void:
	Globals.packages_count = DayManager.current_day.packages_amount
	Globals.packages_current_count = 0
	Globals.strikes_count = DayManager.current_day.strikes_amount
	Globals.strikes_current_count = 0


func spawn_package() -> void:
	if Globals.packages_current_count >= Globals.packages_count:
		if DayManager.is_last_day():
			SceneManager.load_scene(SceneManager.ending_scene)
		else:
			DayManager.increase_day()
			SceneManager.load_scene(SceneManager.galactic_bulletin_scene)
		return
	
	
	if DayManager.is_last_day() and Globals.packages_current_count == Globals.packages_count - 1:
		package_spawner.spawn_ceo()
	else:
		package_spawner.spawn_package()
	


func _on_emergency_button_pressed():
	toggle_buttons(false)
	emergency_mode_toggled.emit(true)
	time_left_progress_bar.start_timer(DayManager.current_day.emergency_time_left, time_left_progress_bar.TimerType.EMERGENCY)


func _on_accept_button_pressed():
	toggle_buttons(false)
	time_left_progress_bar.stop_timer()
	package_spawner.forward_package()
	

func give_coins(amount: int) -> void:
	Globals.coins += amount


func strike() -> void:
	Globals.strikes_current_count += 1
	
	if Globals.strikes_current_count >= Globals.strikes_count:
		SceneManager.load_scene(SceneManager.game_over_scene)


func destroy_package() -> void:
	package_spawner.destroy_current_package()
	
	

func _on_emergency_module_emergency_code_checked(is_correct):
	if not is_correct:
		return
	
	package_spawner.destroy_current_package()
	
	time_left_progress_bar.stop_timer()
	emergency_mode_toggled.emit(false)
	


func _on_timer_to_spawn_package_timeout():
	spawn_package()


func _on_timer_extra_time_timeout():
	toggle_buttons(false)
	
	if package_spawner.current_package.is_evil():
		package_spawner.forward_package()
	else:
		package_spawner.destroy_current_package()
	
	
	emergency_mode_toggled.emit(false)


func toggle_buttons(enabled: bool) -> void:
	accept_button.disabled = !enabled
	emergency_button.disabled = !enabled


func _on_package_spawner_package_delivered():
	time_left_progress_bar.start_timer(DayManager.current_day.normal_time_left, time_left_progress_bar.TimerType.NORMAL)
	toggle_buttons(true)
	xray.visible = true


func _on_package_spawner_package_forwarded(is_evil):
	if is_evil:
		strike()
	else:
		give_coins(5)
		
	xray.visible = false
	timer_to_spawn_package.start()


func _on_package_spawner_package_destroyed(is_evil):
	if is_evil:
		give_coins(5)
	else:
		strike()
		
	xray.visible = false
	timer_to_spawn_package.start()


func _on_begin_button_pressed():
	info_paper.visible = false
	spawn_package()
	

