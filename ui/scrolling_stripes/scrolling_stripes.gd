extends Panel

@export var speed: float
@export var color: Color

func _ready() -> void:
	material.set_shader_parameter("speed", speed)
	material.set_shader_parameter("color", color)
