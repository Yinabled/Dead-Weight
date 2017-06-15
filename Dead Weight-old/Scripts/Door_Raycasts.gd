extends RayCast2D

onready var name = get_name()
var puzzle_num
var send_to_scene


func _ready():
	print(name)
	if name.find("Cabin") > -1:
		send_to_scene = "Cabin_Cutscene" #PROPER SCENE NAME?
	else:
		puzzle_num = name
		puzzle_num.erase(0, 5)
		send_to_scene = "Puzzle_" + puzzle_num
	
	set_process(true)


func _process(delta):
	if is_colliding() && get_collider().get_name() == "Player" && Input.is_action_pressed("ui_e"):
		set_enabled(false)
		Stage_manager.change_stage(send_to_scene, true, true)