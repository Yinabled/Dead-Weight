extends StaticBody2D

var top
var collided

func _ready():
	top = get_node("top")
	top.add_exception(self)
	collided = false
	set_process(true)

func _process(delta):
	if top.is_colliding() && !collided && top.get_collider().get_name().find("Moving_plat") == -1:
		get_node("SamplePlayer").play("falling_on_spikes")
		Puzzle_HUD.get_node("Timer_Sprite").restart_puzzle()
		collided = true