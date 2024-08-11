extends Node2D

@onready var button_pressed_stream_player = %ButtonPressedStreamPlayer
@onready var logo_panel = %LogoPanel
@onready var dark_panel = %DarkPanel

func _on_menu_button_pressed():
	button_pressed_stream_player.play()
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(dark_panel, "modulate:a", 1, 1)
	await tween.finished
	
	tween = get_tree().create_tween()
	logo_panel.show()
	tween.tween_property(dark_panel, "modulate:a", 0, 1)
	
	await get_tree().create_timer(5).timeout
	tween = get_tree().create_tween()
	tween.tween_property(dark_panel, "modulate:a", 1, 1)
	await tween.finished
	
	DayManager.set_current_day(DayManager.days.size() - 1)
	SceneManager.load_scene(SceneManager.menu_scene)
