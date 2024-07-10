class_name Tile
extends Sprite2D

var _definition: TileDefinition
var grid_position: Vector2i
var tile_type: int


var is_explored: bool = false:
	set(value):
		is_explored = value
		if is_explored and not visible:
			visible = true

var is_in_view: bool = false:
	set(value):
		is_in_view = value
		modulate = _definition.color_lit if is_in_view else _definition.color_dark
		if is_in_view and not is_explored:
			is_explored = true
			
func _init(_grid_position: Vector2i, _tile_type: int) -> void:
	tile_type = _tile_type
	visible = false
	centered = false
	position = Grid.grid_to_world(_grid_position)
	grid_position = _grid_position
	set_tile_type(_tile_type)

func set_tile_type(_tile_type: int) -> void:
	var tile_definition: TileDefinition
	if tile_type == MapData.tile_types.wall:
		tile_definition = Rand.weighted_pick(MapData.wall_tiles, MapData.wall_tiles_weight)
	if tile_type == MapData.tile_types.floor:
		tile_definition = Rand.weighted_pick(MapData.floor_tiles, MapData.floor_tiles_weight)

	_definition = tile_definition
	texture = _definition.texture
	modulate = _definition.color_dark

func is_walkable() -> bool:
	return _definition.is_walkable

func is_transparent() -> bool:
	return _definition.is_transparent
