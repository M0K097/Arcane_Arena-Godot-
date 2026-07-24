extends Sprite2D

var possible_pickups: Array[PickupResource] = [preload("res://resources/pickup_ice_wand.tres"),preload("res://resources/pickup_fire_wand.tres")]
var wand = preload("res://scenes/MagicWand.tscn")
var choosen_pickup: PickupResource
var arena: Rect2

func _ready() -> void:
	var pick = randi_range(0,possible_pickups.size()-1)
	choosen_pickup = possible_pickups[pick]
	texture = choosen_pickup.icon
	arena = Rect2(Vector2(-100,-50), Vector2(-100,-50))
	_fancy_placement()

func _process(_delta: float) -> void:
	var tween = create_tween()
	var flicker = randf_range(0.5,1.5)
	tween.tween_property($PointLight2D, "scale", Vector2(flicker, flicker),0.1).set_trans(Tween.TRANS_LINEAR)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var new_wand = wand.instantiate()
		new_wand.set_weapon_data(choosen_pickup.Weapon_Resource)
		var tween = create_tween()
		tween.parallel().tween_property(self, "scale", Vector2(0.8,0.8), 0.3).set_trans(Tween.TRANS_BOUNCE)
		await tween.finished
		body.call_deferred("add_child",new_wand)
		queue_free()

func get_random_place_inside_arena(arena_rect: Rect2):
	var x = randf_range(arena_rect.position.x, arena_rect.end.x)
	var y = randf_range(arena_rect.position.y, arena_rect.end.y)
	return Vector2(x,y)
	

func _fancy_placement():
	var tween = create_tween()
	var placement = get_random_place_inside_arena(arena)
	tween.parallel().tween_property(self, "position", position + Vector2(0,-50), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(self, "scale", Vector2(0.6,0.6), 0.3).set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	var tween2 = create_tween()
	tween2.parallel().tween_property(self, "position", placement, 1).set_trans(Tween.TRANS_ELASTIC)
	tween2.parallel().tween_property(self, "scale", Vector2(0.4,0.4), 0.5).set_trans(Tween.TRANS_LINEAR)
	
