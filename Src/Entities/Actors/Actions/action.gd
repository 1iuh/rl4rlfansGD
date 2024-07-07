class_name Action
extends RefCounted

var entity: Entity
var classname: String = "Action"
#wats dis?dis es mine nam cuz gdscript dono gimme one!


func _init(_entity: Entity) -> void:
	self.entity = _entity
	
func perform() -> void:
	pass

func get_map_data() -> MapData:
	return entity.map_data
