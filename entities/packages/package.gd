class_name Package extends Node2D

@export var x_ray_sprites: Array[Texture2D]
@export var window_mask: CanvasItemMaterial

var x_ray_sprite


var package_type: String


func init_package(package_type: String) -> void:
	self.package_type = package_type
	
	x_ray_sprite = %XRaySprite
	x_ray_sprite.material = window_mask
	
	%NormalSprite.material = window_mask
	
	set_random_xray_sprite()
	
	match(package_type):
		Globals.ALIEN_IN_PACKAGE:
			spawn_alien_inside()	
		Globals.ALIEN_PARTS_IN_PACKAGE:
			spawn_alien_parts_inside(false)
		Globals.ALIEN_PARTS_IN_PACKAGE_TIMER:
			spawn_alien_parts_inside(true)

func spawn_alien_inside() -> void:
	var alien: Alien = AlienDatabase.get_random_alien_scene().instantiate()
	add_child(alien)
	alien.material = window_mask
	alien.global_position = global_position
	alien.start_animations()

func spawn_alien_parts_inside(with_timer: bool) -> void:
	var parts_holder: Node2D
	var difficulty: String = Globals.get_dictionary_key_based_on_odds(DayManager.current_day.alien_parts_difficulty_odds)
	
	match(difficulty):
		Globals.ALIEN_PARTS_EASY:
			parts_holder = %Easy
		Globals.ALIEN_PARTS_MEDIUM:
			parts_holder = %Medium
		Globals.ALIEN_PARTS_HARD:
			parts_holder = %Hard
	
	var available_spawn_points: Array[Node] = parts_holder.get_children()
	var parts_amount = randi_range(3, available_spawn_points.size())
	var random_alien_part_index = AlienDatabase.get_random_alien_part_index()
	var random_alien_part_scene = AlienDatabase.get_alien_part_scene(random_alien_part_index)
	
	for i in range(parts_amount):
		var spawn_point: Marker2D = available_spawn_points.pick_random()
		available_spawn_points.erase(spawn_point)
		
		var alien_part: Alien = random_alien_part_scene.instantiate()
		add_child(alien_part)
		alien_part.get_child(0).material = window_mask
		alien_part.global_position = spawn_point.global_position
		alien_part.rotation = randf_range(-6.2, 6.2)
		alien_part.start_animations()
		
		if with_timer:
			alien_part.visible = false
			var time_to_show: float = randf_range(DayManager.current_day.normal_time_left * 0.25, DayManager.current_day.normal_time_left * 0.7)
			var timer: SceneTreeTimer = get_tree().create_timer(time_to_show)
			timer.timeout.connect(show_alien_part.bind(alien_part))
			
func show_alien_part(alien_part: Node2D) -> void:
	alien_part.visible = true


func set_random_xray_sprite() -> void:
	#if package_type != Globals.ALIEN_IN_PACKAGE:
	%XRaySprite.texture = x_ray_sprites.pick_random()


func is_evil() -> bool:
	return package_type != Globals.NORMAL_PACKAGE
