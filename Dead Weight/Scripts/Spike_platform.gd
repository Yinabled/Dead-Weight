extends StaticBody2D

var top
var collided

func _ready():
	top = get_node("top")
	top.add_exception(self)
	collided = false
	set_process(true)

func _process(delta):
	if top.is_colliding() && !collided:
		Puzzle_HUD.get_node("Timer_Sprite").restart_puzzle() #restart puzzle function call
		collided = true