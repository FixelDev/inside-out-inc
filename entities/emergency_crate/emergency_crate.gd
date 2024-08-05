class_name EmergencyCrate extends Node2D

@onready var animation_player = %AnimationPlayer

var is_emergency_mode: bool = false


func close() -> void:
	animation_player.play("toggle")
	
	
func open() -> void:
	animation_player.play_backwards("toggle")


func _on_game_emergency_mode_toggled(enabled):
	if is_emergency_mode == enabled:
		return
		
	is_emergency_mode = enabled
	
	if enabled:
		close()
	else:
		open()
