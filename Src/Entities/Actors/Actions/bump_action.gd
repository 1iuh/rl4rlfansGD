class_name BumpAction
extends ActionWithDirection


func perform() -> void:
    var destination := Vector2i(entity.grid_position + offset)
    
    if get_map_data().get_blocking_entity_at_location(destination):
        MeleeAction.new(entity, offset.x, offset.y).perform()
    else:
        MovementAction.new(entity, offset.x, offset.y).perform()