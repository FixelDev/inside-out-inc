class_name Alien extends Sprite2D

@export var min_scale: float
@export var max_scale: float

func _ready() -> void:
	var random_scale: float = randf_range(min_scale, max_scale)
	scale = Vector2(random_scale, random_scale)

