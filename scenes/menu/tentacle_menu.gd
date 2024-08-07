extends Control


@export var rotation_offset: float
@export var tween_time: float

var current_rotation: float
var final_rotation: float
var can_move: bool = true


func _ready() -> void:
	current_rotation = rotation
	final_rotation = current_rotation + rotation_offset

func _process(_delta) -> void:
	if not can_move:
		return
		
	can_move = false
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", final_rotation, tween_time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", current_rotation, tween_time).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	
	can_move = true
