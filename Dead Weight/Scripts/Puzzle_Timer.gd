extends Sprite

#Total time for each puzzle, in seconds
var total_puzzle_time = 120

var sprite_size = Vector2(64, 68)
var visible = false


func _ready():
	hide()
	
	#Placing timer in top right corner
	var x = Globals.get("display/width") - sprite_size.x
	var y = sprite_size.y
	set_pos(Vector2(x, y))
	
	get_node("Timer").set_wait_time(float(total_puzzle_time) / (get_hframes() - 1))
	
	set_process(true)


func show_timer(showing):
	if showing:
		visible = true
		show()
	else:
		visible = false
		hide()


func restart_timer():
	show()
	set_frame(0)
	get_node("Timer").start()


func stop_timer():
	get_node("Timer").stop()
	hide()


func _on_Timer_timeout():
	if get_frame() < get_hframes() - 2:
		set_frame(get_frame() + 1)
		get_node("Timer").start()
	else:
		set_frame(get_hframes() - 1)
		#PUZZLE FAILED. RESTART, OR GET SENT BACK TO BRAIN SPACE
