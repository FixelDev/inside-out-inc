class_name EmergencyCrate extends Node2D

@onready var animation_player = %AnimationPlayer


func close() -> void:
	animation_player.play("toggle")
	
	
func open() -> void:
	animation_player.play_backwards("toggle")
