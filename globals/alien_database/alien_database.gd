extends Node

@export var aliens_scenes: Array[PackedScene] = []
@export var alien_parts_scenes: Array[PackedScene] = []


func get_random_alien_scene() -> PackedScene:
	return aliens_scenes.pick_random()
	

func get_random_alien_part_scene() -> PackedScene:
	return alien_parts_scenes.pick_random()
	
	
func get_random_alien_part_index() -> int:
	return randi_range(0, alien_parts_scenes.size() - 1)
	
	
func get_alien_part_scene(index: int) -> PackedScene:
	return alien_parts_scenes[index]
