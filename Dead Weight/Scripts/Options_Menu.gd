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
	Stage_manager.user_volume = value / 100
	
	for track in Stage_manager.music_tracks:
		var max_volume = Stage_manager.OST_max_volumes[track.get_name()]
		track.set_volume(value * max_volume / 100)


func _on_Fullscreen_Button_toggled(pressed):
	OS.set_window_fullscreen(pressed)


func _on_Back_Button_pressed():
	hide()
	if !get_tree().get_current_scene().get_name() == "Main_Menu":
		get_parent().get_node("Pause_Menu").show()
