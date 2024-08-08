class_name AlienPackage extends Package

var can_animate: bool = true

var start_scale: Vector2
var final_scale: Vector2

func _ready() -> void:
	%XRaySprite.material = window_mask	
	%NormalSprite.material = window_mask
	
	var scale_offset: float = randf_range(0.03, 0.1)
	start_scale = Vector2(scale.x + scale_offset, scale.y - scale_offset)
	final_scale = Vector2(scale.x - scale_offset, scale.y + scale_offset)


func _process(_delta) -> void:
	if not can_animate:
		return
		
	can_animate = false
	
	var tween: Tween = get_tree().create_tween()
	var time: float = randf_range(1.2, 1.7)
	
	tween.tween_property(self, "scale", start_scale, time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", final_scale, time).set_trans(Tween.TRANS_CUBIC)
		
	await tween.finished
	
	can_animate = true

	
