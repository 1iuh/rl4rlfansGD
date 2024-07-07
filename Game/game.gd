class_name Game
extends Node2D

signal player_created(player)


const player_definition: EntityDefinition = preload("res://Assets/definitions/entities/entity_definition_player.tres")

@onready var player: Entity
@onready var input_handler: InputHandler = $InputHandler
@onready var map: Map = $Map


func _ready() -> void:
	player = Entity.new(null, Vector2i.ZERO, player_definition)
	print("player init finish")
	player_created.emit(player)
	var camera: Camera2D = $Camera2D
	remove_child(camera)
	player.add_child(camera)
	map.generate(player)
	map.update_fov(player.grid_position)

func get_map_data() -> MapData:
	return map.map_data

func _physics_process(_delta: float) -> void:
	var action: Action = input_handler.get_action(player)
	if action:
		var previous_player_position: Vector2i = player.grid_position
		action.perform()
		#print(action.classname)
		if action.classname == "ZoomAction":
			pass
		else: 
			_handle_enemy_turns()
		
		if player.grid_position != previous_player_position:
			map.update_fov(player.grid_position)

func _handle_enemy_turns() -> void:
	for entity in get_map_data().get_actors():
		if entity.is_alive() and entity != player:
			entity.ai_component.perform()
