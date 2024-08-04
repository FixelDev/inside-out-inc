class_name Package extends Node2D

@export var x_ray_sprites: Array[Texture2D]

@onready var x_ray_sprite = %XRaySprite
@onready var alien_parts_holder = %AlienPartsHolder

enum PackageType {NORMAL, ALIEN, ALIEN_PARTS}

var package_type: PackageType


func _ready() -> void:
	package_type = PackageType.values().pick_random()
	set_random_xray_sprite()
	
	match(package_type):
		PackageType.ALIEN:
			spawn_alien_inside()
			
		PackageType.ALIEN_PARTS:
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
	if package_type != PackageType.ALIEN:
		x_ray_sprite.texture = x_ray_sprites.pick_random()


func is_evil() -> bool:
	return package_type != PackageType.NORMAL
