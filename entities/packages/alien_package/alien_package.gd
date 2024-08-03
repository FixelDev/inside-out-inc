class_name AlienPackage extends Package


func _ready() -> void:
	package_type = PackageType.ALIEN
	set_random_xray_sprite()
	
	
func set_random_xray_sprite() -> void:
	x_ray_sprite.texture = x_ray_sprites.pick_random()
