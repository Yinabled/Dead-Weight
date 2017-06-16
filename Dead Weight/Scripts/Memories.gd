extends Node2D

var max_time = 12

func _ready():
	get_node("SamplePlayer").play("camera_shutter_sound")
	get_node("Black_Border2").hide()
	
	var puzzles_completed = Stage_manager.puzzles_complete
	
	get_node("AnimationPlayer").play("Memory" + str(puzzles_completed))
	if int(puzzles_completed) == 6:
		get_node("Black_Border2").show()
	
	get_node("Timer").set_wait_time(max_time)
	get_node("Timer").start()
	set_process_input(true)


func _input(event):
	if(Input.is_action_pressed("ui_e") || Input.is_action_pressed("ui_accept")):
		Stage_manager.get_node("Extra_SFX").play("memory_door_opening")
		Stage_manager.change_stage("Brain_Space", true, true)


func _on_Timer_timeout():
	Stage_manager.get_node("Extra_SFX").play("memory_door_opening")
	Stage_manager.change_stage("Brain_Space", true, true)