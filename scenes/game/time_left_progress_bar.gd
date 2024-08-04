class_name TimeLeftProgressBar extends ProgressBar

@onready var time_left_label = %TimeLeftLabel
@onready var timer_time_to_left = %TimerTimeToLeft
@onready var timer_extra_time = %TimerExtraTime

var is_timer_in_progress: bool = false


func start_timer(seconds_left: float) -> void:
	max_value = seconds_left
	value = seconds_left
	time_left_label.text = str(seconds_left)
	timer_time_to_left.wait_time = seconds_left
	timer_time_to_left.start()
	is_timer_in_progress = true
	

func stop_timer() -> void:
	timer_extra_time.stop()
	timer_time_to_left.stop()
	is_timer_in_progress = false
	
	
func _process(_delta) -> void:
	if not is_timer_in_progress:
		return
	
	var snapped_value: float = snapped(timer_time_to_left.time_left, 0.1)
	value = timer_time_to_left.time_left
	time_left_label.text = str(snapped_value)


func _on_timer_time_to_left_timeout():
	is_timer_in_progress = false
	timer_extra_time.start()

