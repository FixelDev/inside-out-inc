class_name Package extends Node2D

@export var x_ray_sprites: Array[Texture2D]

@onready var x_ray_sprite = %XRaySprite

enum PackageType {NORMAL, ALIEN, ALIEN_PARTS}

var package_type: PackageType


func _ready() -> void:
	package_type = PackageType.values().pick_random()
	set_random_xray_sprite()
	
	
func set_random_xray_sprite() -> void:
	if package_type != PackageType.ALIEN:
		x_ray_sprite.texture = x_ray_sprites.pick_random()
	else:
		#GENERATE ALIEN
		pass
		
func is_evil() -> bool:
	return package_type != PackageType.NORMAL
