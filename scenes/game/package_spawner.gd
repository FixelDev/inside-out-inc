class_name PackageSpawner extends Node2D

@export var packages_scenes: Array[PackedScene] = []
@export var aliens_scenes: Array[PackedScene] = []
@export var package_spawn_point: Marker2D
@export var package_destination_point: Marker2D
@export var package_forward_point: Marker2D
@export var laser_gun: Marker2D
@export var laser_scene: PackedScene
#@export var xray: Node2D
@export var destroy_particles: CPUParticles2D

signal package_delivered()
signal package_destroyed(is_evil: bool)
signal package_forwarded(is_evil: bool)

var current_package: Package
var laser: Node2D


func spawn_package() -> void:
	var package_type: String = randomize_package_type()
	var package_scene: PackedScene
	
	if package_type == Globals.ALIEN_PACKAGE:
		package_scene = aliens_scenes.pick_random()
	else:
		package_scene = packages_scenes.pick_random()
	
	current_package = package_scene.instantiate()
	package_spawn_point.add_child(current_package)
	current_package.init_package(package_type)
	current_package.global_position = package_spawn_point.global_position
	current_package.rotation = -0.2
	Globals.packages_current_count += 1
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(current_package, "global_position:y", package_destination_point.global_position.y, 1.2).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(current_package, "rotation", 0, 1.2).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	
	package_delivered.emit()


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
	laser = laser_scene.instantiate()
	laser_gun.add_child(laser)
	laser.global_position = laser_gun.global_position
	laser.look_at(package_destination_point.global_position)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(laser, "global_position", package_destination_point.global_position, 0.5).set_trans(Tween.TRANS_QUART)
	
	
func _on_destroy_area_area_entered(area):
	destroy_particles.emitting = true
	package_destroyed.emit(current_package.is_evil())
	laser.queue_free()
	current_package.queue_free()

func forward_package() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(current_package, "global_position", package_forward_point.global_position, 1).set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel().tween_property(current_package, "rotation", -0.2, 0.6).set_trans(Tween.TRANS_CUBIC)
	#add rotation
	
	await tween.finished
	
	package_forwarded.emit(current_package.is_evil())
	current_package.queue_free()
