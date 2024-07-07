class_name MainGameInputHandler
extends BaseInputHandler

const directions = {
	"move_up": Vector2i.UP,
	"move_down": Vector2i.DOWN,
	"move_left": Vector2i.LEFT,
	"move_right": Vector2i.RIGHT,
	"move_up_left": Vector2i.UP + Vector2i.LEFT,
	"move_up_right": Vector2i.UP + Vector2i.RIGHT,
	"move_down_left": Vector2i.DOWN + Vector2i.LEFT,
	"move_down_right": Vector2i.DOWN + Vector2i.RIGHT,
}


func get_action(player: Entity) -> Action:
	var action: Action = null
	var playercamera:Camera2D = null
	
	for direction in directions:
		if Input.is_action_just_pressed(direction):
			var offset: Vector2i = directions[direction]
			action = BumpAction.new(player, offset.x, offset.y)
			
	for childnode in player.get_children():
		if childnode.is_class("Camera2D"):
			playercamera = childnode
			break
			
	if Input.is_action_just_pressed("wait"):
		action = WaitAction.new(player)
	
	if Input.is_action_just_pressed("quit"):
		action = EscapeAction.new(player)
	
	if Input.is_action_just_pressed("zoom_in"):
		action = ZoomAction.new(player,playercamera,true,0.1)
		#action = ZoomAction.new(player,player.get_child(2),true,0.1)
		
	if Input.is_action_just_pressed("zoom_out"):
		action = ZoomAction.new(player,playercamera,false,0.1)
		#action = ZoomAction.new(player,player.get_child(2),false,0.1)
		
	return action
