extends Sprite

#Total time for each puzzle, in seconds
var total_puzzle_time = 120

var sprite_size = Vector2(64, 64)
var visible = false

func _ready():
	hide()
	
	#Placing timer in top right corner
	var x = Globals.get("display/width") - sprite_size.x
	var y = sprite_size.y
	set_pos(Vector2(x, y))
	
	get_node("Timer").set_wait_time(total_puzzle_time / 12)
	print(str(get_node("Timer").get_wait_time()))
	
	set_process(true)



func _on_Timer_timeout():
	set_frame(get_frame() + 1)
