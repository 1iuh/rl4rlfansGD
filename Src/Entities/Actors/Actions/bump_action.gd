class_name BumpAction
extends ActionWithDirection

func _init(_entity:Entity, _dx: int, _dy: int)->void:
	super._init(_entity, _dx, _dy)
	classname = "BumpAction"

func perform() -> void:
	if get_target_actor():
		MeleeAction.new(entity, offset.x, offset.y).perform()
	else:
		MovementAction.new(entity, offset.x, offset.y).perform()
