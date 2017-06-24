extends RayCast2D

onready var E_button = get_node("E_Button")

onready var name = get_name()
var cabin = false
var send_to_scene

var puzzle_num


func _ready():
	var puzzles_completed = Stage_manager.puzzles_complete
	
	if name.find("Cabin") > -1:
		cabin = true
		send_to_scene = "Cabin_Cutscene"
		
		if !Stage_manager.player_bandaged:
			set_enabled(true)
		else:
			set_enabled(false)
	else:
		send_to_scene = name
		send_to_scene.erase(0, 5)
		get_parent().get_node("Colliders/Right_Wall").set_pos(Vector2(1350 + (int(puzzles_completed) - 1)*690, 800))
		
		puzzle_num = name
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
	
	if is_colliding():
		E_button.show()
	else:
		E_button.hide()