class_name InputHandler
extends Node

enum InputHandlers {MAIN_GAME, GAME_OVER}

@export var start_input_handler: InputHandlers

@onready var input_handler_nodes := {
	InputHandlers.MAIN_GAME: $MainGameInputHandler,
	InputHandlers.GAME_OVER: $GameOverInputHandler,
}

var current_input_handler: BaseInputHandler


func _ready() -> void:
	transition_to(start_input_handler)
	SignalBus.player_died.connect(transition_to.bind(InputHandlers.GAME_OVER))


func get_action(player: Entity) -> Action:
	return current_input_handler.get_action(player)


func transition_to(input_handler: InputHandlers) -> void:
	current_input_handler = input_handler_nodes[input_handler]
