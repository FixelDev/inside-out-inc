class_name TimeLeftProgressBar extends TextureProgressBar

@onready var time_left_label = %TimeLeftLabel
@onready var timer_time_to_left = %TimerTimeToLeft
@onready var timer_extra_time = %TimerExtraTime
@onready var fill_emergency = %FillEmergency
@onready var fill_normal = %FillNormal

enum TimerType {NORMAL, EMERGENCY}

var is_timer_in_progress: bool = false
var seconds_left: float

func start_timer(seconds_left: float, timer_type: TimerType) -> void:
	self.seconds_left = seconds_left
	max_value = seconds_left
	value = 0
	time_left_label.text = str(seconds_left)
	timer_time_to_left.wait_time = seconds_left
	timer_time_to_left.start()
	is_timer_in_progress = true
	
	match timer_type:
		TimerType.NORMAL:
			fill_normal.visible = true
			fill_emergency.visible = false
		TimerType.EMERGENCY:
			fill_normal.visible = false
			fill_emergency.visible = true	
		
	

func stop_timer() -> void:
	timer_extra_time.stop()
	timer_time_to_left.stop()
	is_timer_in_progress = false
	
	
func _process(_delta) -> void:
	if not is_timer_in_progress:
		return
	
	var snapped_value: float = snapped(timer_time_to_left.time_left, 0.1)
	value = seconds_left - timer_time_to_left.time_left
	time_left_label.text = str(snapped_value)


func _on_timer_time_to_left_timeout():
	is_timer_in_progress = false
	timer_extra_time.start()

