class_name Action
extends RefCounted

var entity: Entity


func _init(_entity: Entity) -> void:
	self.entity = _entity

func perform() -> void:
	pass

func get_map_data() -> MapData:
	return entity.map_data
