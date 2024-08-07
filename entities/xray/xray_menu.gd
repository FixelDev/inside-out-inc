extends PointLight2D


@onready var xray_positions: Node2D = %XrayPositions

var current_position_index: int = 1
var can_move: bool = true

func _process(delta) -> void:
	if not can_move:
		return
		
	can_move = false
	
	var next_position: Vector2 = xray_positions.get_children()[current_position_index].global_position
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", next_position, 0.8).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	
	var timer: SceneTreeTimer = get_tree().create_timer(0.6)
	timer.timeout.connect(enable_xray_movement)
	current_position_index += 1
	
	if current_position_index >= xray_positions.get_children().size():
		current_position_index = 0

func enable_xray_movement() -> void:
	can_move = true
