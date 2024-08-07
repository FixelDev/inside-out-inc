extends Node2D

@onready var pause_panel = %PausePanel


func _input(event) -> void:
	if event.is_action_pressed("pause"):
		pause_panel.show()
		get_tree().paused = true
	


func _on_resume_button_pressed():
	pause_panel.hide()
	get_tree().paused = false


func _on_menu_button_pressed():
	SceneManager.load_scene(SceneManager.menu_scene)
	get_tree().paused = false
