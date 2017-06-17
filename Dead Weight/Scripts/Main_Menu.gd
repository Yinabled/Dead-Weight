extends Node2D


func _ready():
#	get_tree().call_group(0, "Soundtrack", "stop")
#	Stage_manager.get_node("Main-Menu_Track").play()
	pass


func _on_Play_Game_Button_pressed():
	Stage_manager.change_stage("Intro_cutscene", true, true)


func _on_Quit_Button_pressed():
	get_tree().quit()