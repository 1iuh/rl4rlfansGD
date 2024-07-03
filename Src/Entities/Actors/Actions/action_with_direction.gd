class_name ActionWithDirection
extends Action

var offset: Vector2i


func _init(_entity: Entity, dx: int, dy: int) -> void:
	super._init(_entity)
	offset = Vector2i(dx, dy)

func get_destination() -> Vector2i:
	return entity.grid_position + offset

func get_blocking_entity_at_destination() -> Entity:
	return get_map_data().get_blocking_entity_at_location(get_destination())