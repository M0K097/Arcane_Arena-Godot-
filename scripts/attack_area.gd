extends Area2D

func get_closest_enemy() -> CharacterBody2D:
	var closest_enemy
	var objects_in_range = get_overlapping_bodies()
	var distance_to_closest_enemy = INF
	for object in objects_in_range:
		var distance = global_position.distance_to(object.global_position)
		if distance < distance_to_closest_enemy and object is Enemy:
				closest_enemy = object
				distance_to_closest_enemy = distance
	
	return closest_enemy
