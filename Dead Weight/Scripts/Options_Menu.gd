extends Panel

func _ready():
	var x = (Globals.get("display/width") - get_size().x) / 2
	var y = (Globals.get("display/height") - get_size().y) / 2
	set_pos(Vector2(x, y))
	
	if Globals.get("display/fullscreen"):
		get_node("Fullscreen Button").set_pressed(true)
	else:
		get_node("Fullscreen Button").set_pressed(false)
	
	self.hide()


func _on_Volume_Slider_value_changed(value):
	Globals.set("audio/stream_volume_scale", int(value/50))
	Globals.set("audio/fx_volume_scale", int(value/50))
	print("Should be set to " + str(value))


func _on_Fullscreen_Button_toggled(pressed):
	OS.set_window_fullscreen(pressed)
	print("Should set to " + str(pressed))


func _on_Back_Button_pressed():
	hide()
	if !get_tree().get_current_scene().get_name() == "Main_Menu":
		get_parent().get_node("Pause_Menu").show()
