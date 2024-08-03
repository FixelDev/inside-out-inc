class_name Alien extends Sprite2D

@export var alien_sprites: Array[Texture2D]


func _ready() -> void:
	texture = alien_sprites.pick_random()

