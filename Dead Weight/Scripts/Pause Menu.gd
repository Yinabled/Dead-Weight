extends Panel

const animation_Time = 0.2
var pause_Timer = animation_Time

onready var retry_button = Puzzle_HUD.get_node("Timer_Sprite/Retry_Button")


func _ready():
	#Centering pause menu
	var x = (Globals.get("display/width") - get_size().x) / 2
	var y = (Globals.get("display/height") - get_size().y) / 2
	set_pos(Vector2(x, y))
	
	self.hide()
	set_process(true)
	set_process_input(true)


func _process(delta):
	pause_Timer -= delta


func _input(event):
	if(Input.is_action_pressed("ui_cancel") && pause_Timer < 0 && get_tree().get_current_scene().get_name() != "Main_Menu"):
		_on_Resume_Button_pressed()
		pause_Timer = animation_Time


func _on_Resume_Button_pressed():
	if (get_tree().is_paused()):
		self.hide()
		retry_button.hide()
		
		get_tree().set_pause(false)
	else:
		self.show()
		
		if Stage_manager.is_puzzle():
			retry_button.show()
		
		get_tree().set_pause(true)


#DELETE THIS BUTTON FROM PAUSE MENU BUT do NOT remove function, it is used for puzzle restart
func _on_Restart_Scene_Button_pressed():
	Stage_manager.change_stage(get_tree().get_current_scene().get_name(), true, true)
	self.hide()
	get_tree().set_pause(false)


func _on_Restart_Game_Button_pressed():
	Stage_manager.change_stage("Intro_cutscene", true, true)
	self.hide()
	get_tree().set_pause(false)


func _on_Main_Menu_Button_pressed():
	Stage_manager.change_stage("Main_Menu", true, true)
	self.hide()
	get_tree().set_pause(false)


func _on_Quit_Button_pressed():
	get_tree().quit()
