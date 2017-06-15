extends RayCast2D

var E_button
var button_playing = false

onready var name = get_name()
var cabin = false
var send_to_scene


func _ready():
	if name.find("Cabin") > -1:
		cabin = true
		E_button = get_parent().get_node("E_button")
		send_to_scene = "Cabin_Cutscene"
	else:
		send_to_scene = name
		send_to_scene.erase(0, 5)
	
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