extends Node2D

@export var transition: Panel

@export var game_scene: PackedScene
@export var menu_scene: PackedScene
@export var galactic_bulletin_scene: PackedScene
@export var game_over_scene: PackedScene
@export var ending_scene: PackedScene

var is_chaning_scene: bool = false


func load_scene(scene_to_load: PackedScene) -> void:
	if is_chaning_scene:
		return
	
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(transition, "size:y", 720, 1).set_trans(Tween.TRANS_CUBIC)
	is_chaning_scene = true
	
	await tween.finished
	
	get_tree().change_scene_to_packed(scene_to_load)
	
	var tween2: Tween = get_tree().create_tween()
	tween2.tween_property(transition, "size:y", 0, 1).set_trans(Tween.TRANS_CUBIC)
	is_chaning_scene = false
