extends Node2D

signal next_step
var eraseID:Vector2i = Vector2i(0,1)
# Called when the node enters the scene tree for the first time.
func _ready():
	#$WFC2DGenerator.start()
	$Sample_full.hide()
	#$Sample_wall.hide()
	$NegativeSample.hide()
	$Target_empty.show()
	
	$Target_empty.notify_runtime_tile_data_update()
	$Target_preload_wall.hide()
	await self.next_step
	$WFC2DGenerator_preduengeon.start()
	print("0")
	await $WFC2DGenerator_preduengeon.done
	print("1")
	await self.next_step
	for cell in $Target_empty.get_used_cells(0):
		#print("cell:",cell,"alia_coord:",$Target_empty.get_cell_atlas_coords(0,cell,false))
		if cell != Vector2i(-1,-1) and $Target_empty.get_cell_atlas_coords(0,cell,false) == eraseID:
			$Target_empty.erase_cell(0,cell)
	await self.next_step
	print("2")
	$WFC2DGenerator.target = $Target_empty.get_path()
	await self.next_step
	$WFC2DGenerator.start()
	print("3")

func _physics_process(delta:float)->void:
	if Input.is_action_just_pressed("wait"):
		next_step.emit()
