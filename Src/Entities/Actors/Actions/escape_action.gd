class_name EscapeAction
extends Action

func _init(_entity:Entity)-> void:
	super._init(_entity)
	classname = "EscapeAction"

func perform() -> void:
	entity.get_tree().quit()
