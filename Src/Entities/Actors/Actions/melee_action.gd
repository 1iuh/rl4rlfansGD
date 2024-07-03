class_name MeleeAction
extends ActionWithDirection


func perform() -> void:
	var target: Entity = get_blocking_entity_at_destination()
	if not target:
		return
	print("You kick the %s, much to it's annoyance!" % target.get_entity_name())