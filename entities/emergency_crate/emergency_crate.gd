class_name EmergencyCrate extends Node2D

@onready var animation_player = %AnimationPlayer
@onready var emergency_crate_starting_point = %EmergencyCrateStartingPoint
@onready var emergency_crate_ending_point_point = %EmergencyCrateEndingPointPoint

var is_emergency_mode: bool = false


func close() -> void:
	move(emergency_crate_ending_point_point.global_position)
	
func open() -> void:
	move(emergency_crate_starting_point.global_position)

func move(final_position: Vector2) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "position", final_position, 0.7).set_trans(Tween.TRANS_CUBIC)


func _on_game_emergency_mode_toggled(enabled):
	if is_emergency_mode == enabled:
		return
		
	is_emergency_mode = enabled
	
	if enabled:
		close()
	else:
		open()
