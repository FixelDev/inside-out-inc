class_name Alien extends Node2D

@export var min_scale: float
@export var max_scale: float

@export var is_swing_animation: bool
@export var is_bounce_animation: bool

var can_animate: bool = false

var start_rotation: float
var final_rotation: float

var start_scale: Vector2
var final_scale: Vector2


func _ready() -> void:
	pass


func _process(_delta) -> void:
	if not can_animate:
		return
		
	can_animate = false
	
	var tween: Tween = get_tree().create_tween()
	var time: float = randf_range(1.2, 1.7)
	
	if is_swing_animation:
		tween.tween_property(self, "rotation", start_rotation, time).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "rotation", final_rotation, time).set_trans(Tween.TRANS_CUBIC)
	
	if is_bounce_animation:
		tween.tween_property(self, "scale", start_scale, time).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "scale", final_scale, time).set_trans(Tween.TRANS_CUBIC)
		
	await tween.finished
	
	can_animate = true


func start_animations() -> void:
	var random_scale: float = randf_range(min_scale, max_scale)
	scale = Vector2(random_scale, random_scale)
	
	if is_swing_animation:
		var swing_offset: float = randf_range(0.1, 0.2)
		start_rotation = rotation - swing_offset
		final_rotation = rotation + swing_offset
	
	if is_bounce_animation:
		var scale_offset: float = randf_range(0.03, 0.1)
		start_scale = Vector2(scale.x + scale_offset, scale.y - scale_offset)
		final_scale = Vector2(scale.x - scale_offset, scale.y + scale_offset)
	
	can_animate = true
