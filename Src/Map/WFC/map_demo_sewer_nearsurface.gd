extends Node2D

signal next_step
var eraseID:Vector2i = Vector2i(0,1)
@onready var input_handler = $MainGameInputHandler
@export var target:TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	$generator/sample.hide()
	$generator/sample_negative.hide()
	$generator/target.hide()
	$generator/demo_map.show()
	$generator.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta:float)->void:
	if Input.is_action_just_pressed("wait"):
		next_step.emit()
	var entity: Entity = null
	var action: Action = input_handler.get_action(entity)
	if action:
		action.perform()
