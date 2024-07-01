class_name MapData
extends RefCounted

const tile_types = {
	"floor": [
		preload("res://Assets/definitions/tiles/tile_definition_floor.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_floor1.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_floor2.tres"),
		],
	"wall": [
		preload("res://Assets/definitions/tiles/tile_definition_wall.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_wall1.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_wall2.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_wall3.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_wall4.tres"),
		preload("res://Assets/definitions/tiles/tile_definition_wall5.tres"),
		],
}

var width: int
var height: int
var tiles: Array[Tile]
var entities: Array[Entity]


func _init(map_width: int, map_height: int) -> void:
	width = map_width
	height = map_height
	entities = []
	_setup_tiles()

func _setup_tiles() -> void:
	tiles = []
	for y in height:
		for x in width:
			var tile_position := Vector2i(x, y)
			var wall = Rand.weighted_pick(tile_types.wall, [220,5,5,5,5,5])
			var tile := Tile.new(tile_position, wall)
			tiles.append(tile)

func get_tile(grid_position: Vector2i) -> Tile:
	var tile_index: int = grid_to_index(grid_position)
	if tile_index == -1:
		return null
	return tiles[tile_index]
	
func grid_to_index(grid_position: Vector2i) -> int:
	if not is_in_bounds(grid_position):
		return -1
	return grid_position.y * width + grid_position.x
	
func is_in_bounds(coordinate: Vector2i) -> bool:
	return (
		0 <= coordinate.x
		and coordinate.x < width
		and 0 <= coordinate.y
		and coordinate.y < height
	)

func get_tile_xy(x: int, y: int) -> Tile:
	var grid_position := Vector2i(x, y)
	return get_tile(grid_position)


func get_blocking_entity_at_location(grid_position: Vector2i) -> Entity:
	for entity in entities:
		if entity.is_blocking_movement() and entity.grid_position == grid_position:
			return entity
	return null
