class_name Roof
extends Node

const roof_tile = preload("res://Assets/definitions/tiles/tile_definition_roof.tres")

var width: int
var height: int
var _roof_tiles: Array[Tile] = []

func init(map_width: int, map_height: int) -> void:
    width = map_width
    height = map_height
    _setup_tiles()


func update_roof(map_data: MapData) -> void:
    for tile in map_data.tiles:
        if tile.is_explored and not tile.is_walkable():
            _add_roof(map_data, tile.grid_position, tile.is_in_view)


func get_tile(grid_position: Vector2i) -> Tile:
    var tile_index: int = grid_to_index(grid_position)
    if tile_index == -1:
        return null
    return _roof_tiles[tile_index]


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

func _setup_tiles() -> void:
    for y in height:
        for x in width:
            var tile_position := Vector2i(x, y)
            var tile := Tile.new(tile_position, roof_tile)
            _roof_tiles.append(tile)
            add_child(tile)


func _clean_roof():
    for tile in _roof_tiles:
        tile.is_in_view = true


func get_tile_xy(x: int, y: int) -> Tile:
    var grid_position := Vector2i(x, y)
    return get_tile(grid_position)


func _add_roof(map_data: MapData, grid_position: Vector2i, is_in_view: bool):
    var tile := get_tile_xy(grid_position.x, grid_position.y -1)
    if tile == null:
        return
    tile.is_explored = true
    tile.is_in_view = is_in_view
    var map_tile := map_data.get_tile_xy(grid_position.x, grid_position.y -1)
    if map_tile.is_walkable():
        tile.modulate.a = 0.5
