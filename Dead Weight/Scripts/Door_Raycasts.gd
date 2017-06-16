extends RayCast2D

var E_button
var button_playing = false

onready var name = get_name()
var cabin = false
var send_to_scene
var collider_moved = false


func _ready():
	var puzzles_completed = Stage_manager.puzzles_complete
	
	if name.find("Cabin") > -1:
		cabin = true
		E_button = get_parent().get_node("E_button")
		send_to_scene = "Cabin_Cutscene"
		
		if !Stage_manager.player_bandaged:
			set_enabled(true)
		else:
			set_enabled(false)
	else:
		send_to_scene = name
		send_to_scene.erase(0, 5)
		get_parent().get_node("Colliders/Right_Wall").set_pos(Vector2(1350 + (int(puzzles_completed) - 1)*690, 800))
		
		var puzzle_num = name
		puzzle_num.erase(0, 12)
		if int(puzzle_num) == int(puzzles_completed) + 1:
			set_enabled(true)
		else:
			set_enabled(false)
	
	set_process(true)


func _process(delta):
	if is_colliding() && get_collider().get_name() == "Player" && Input.is_action_pressed("ui_e"):
		set_enabled(false)
		Stage_manager.change_stage(send_to_scene, true, true)
	
	#Displaying 'E' button if in Outside_Cabin scene
	if cabin:
		if is_colliding():
			if !button_playing:
				E_button.get_node("Anim").play("Floating")
				button_playing = true
		else:
			E_button.hide()
			E_button.get_node("Anim").stop_all()
			button_playing = false