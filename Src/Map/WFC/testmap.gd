extends Node2D

signal next_step
var eraseID:Vector2i = Vector2i(0,1)
@export var target:TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	#$WFC2DGenerator.start()
	#$Sample_full.hide()
	#$Sample_wall.hide()
	#$NegativeSample.hide()	
	#$Target_empty.show()
	#
	#$Target_empty.notify_runtime_tile_data_update()
	#$Target_preload_wall.hide()
	await self.next_step
	$WFC2DGenerator_preduengeon.start()
	print("0")
	await $WFC2DGenerator_preduengeon.done
	print("1")
	await self.next_step
	
	print("2")
	for cell in target.get_used_cells(0):
		if cell != Vector2i(-1,-1) and target.get_cell_atlas_coords(0,cell,false) == eraseID:
			target.erase_cell(0,cell)
	await self.next_step	
	$WFC2DGenerator.start()
	await self.next_step
	print("3")
	$WFC2DGenerator.target = $Target_empty.get_path()
	await self.next_step
	$WFC2DGenerator.start()
	print("4")

func _physics_process(delta:float)->void:
	if Input.is_action_just_pressed("wait"):
		next_step.emit()
