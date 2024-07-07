class_name ZoomAction
extends Action

var camera:Camera2D
var offset:float
var zoomin:bool

func _init(_entity:Entity,_camera: Camera2D,_zoomin:bool,_offset:float)->void:
	super._init(_entity)
	camera = _camera
	offset = _offset
	zoomin = _zoomin
	classname = "ZoomAction"
	

func perform()->void:
	var zoom_new = (
		camera.zoom.x + offset if zoomin
		else camera.zoom.x - offset
	)
	camera.zoom = Vector2(zoom_new,zoom_new)
	
