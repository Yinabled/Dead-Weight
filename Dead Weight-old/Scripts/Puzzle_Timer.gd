extends Sprite

#Total time for each puzzle, in seconds
var total_puzzle_time = 120

var offset = Vector2(-80, 68)
var visible = false


func _ready():
	hide()
	
	#Placing timer in top right corner
	var x = Globals.get("display/width") + offset.x
	var y = offset.y
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


func _on_Retry_Button_pressed():
	get_node("Retry_Button").hide()
	Pause_HUD.get_node("Pause_Menu")._on_Restart_Scene_Button_pressed()


func restart_puzzle():
	Stage_manager.change_stage(get_tree().get_current_scene().get_name(), true, true)