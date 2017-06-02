extends Panel

const animation_Time = 0.2
var pause_Timer = animation_Time


func _ready():
	var x  = (Globals.get("display/width") - get_size().x) / 2
	var y = (Globals.get("display/height") - get_size().y) / 2
	set_pos(Vector2(x, y))
	
	self.hide()
	set_process(true)
	set_process_input(true)


func _process(delta):
	pause_Timer -= delta


func _input(event):
	if(Input.is_action_pressed("ui_cancel") && pause_Timer < 0):
#		var screen = get_tree().get_root().get_rect().size
#		var player = get_parent().get_parent()
#		set_pos(player.get_node("Camera2D").get_camera_screen_center() + screen/2)
#		print(get_pos())
		
		_on_Resume_Button_pressed()
		pause_Timer = animation_Time


func _on_Resume_Button_pressed():
	if (get_tree().is_paused()):
		self.hide()
		get_tree().set_pause(false)
	else:
		self.show()
		get_tree().set_pause(true)

func _on_Quit_Button_pressed():
	get_tree().quit()