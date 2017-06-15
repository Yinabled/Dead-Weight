extends StaticBody2D

var top

func _ready():
	top = get_node("top")
	set_process(true)

func _process(delta):
	if top.is_colliding():
		Puzzle_HUD.get_node("Timer_Sprite").restart_puzzle() #restart puzzle function call