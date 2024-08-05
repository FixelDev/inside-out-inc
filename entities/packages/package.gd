class_name Package extends Node2D

@export var x_ray_sprites: Array[Texture2D]

var x_ray_sprite
var alien_parts_holder


var package_type: String


func init_package(package_type: String) -> void:
	self.package_type = package_type
	
	x_ray_sprite = %XRaySprite
	alien_parts_holder = %AlienPartsHolder
	
	set_random_xray_sprite()
	
	match(package_type):
		Globals.ALIEN_IN_PACKAGE:
			spawn_alien_inside()
			
		Globals.ALIEN_PARTS_IN_PACKAGE:
			spawn_alien_parts_inside()


func spawn_alien_inside() -> void:
	var alien: Alien = AlienDatabase.get_random_alien_scene().instantiate()
	add_child(alien)
	alien.global_position = global_position


func spawn_alien_parts_inside() -> void:
	var available_spawn_points: Array[Node] = alien_parts_holder.get_children()
	var parts_amount = randi_range(1, available_spawn_points.size())
	var random_alien_part_index = AlienDatabase.get_random_alien_part_index()
	var random_alien_part_scene = AlienDatabase.get_alien_part_scene(random_alien_part_index)
	
	for i in range(parts_amount):
		var spawn_point: Marker2D = available_spawn_points.pick_random()
		available_spawn_points.erase(spawn_point)
		
		var alien_part = random_alien_part_scene.instantiate()
		add_child(alien_part)
		alien_part.global_position = spawn_point.global_position


func set_random_xray_sprite() -> void:
	if package_type != Globals.ALIEN_IN_PACKAGE:
		%XRaySprite.texture = x_ray_sprites.pick_random()


func is_evil() -> bool:
	return package_type != Globals.NORMAL_PACKAGE
