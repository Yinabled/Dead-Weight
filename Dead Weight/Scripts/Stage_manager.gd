extends Node

onready var white = get_node("Overlay/Texture_White")
onready var black = get_node("Overlay/Texture_Black")
onready var anim = get_node("AnimationPlayer")
var player_cutscene = true
var player_bandaged = true

var left_enter = true
var current_scene


func _ready():
	player_cutscene = true
	get_node("Rain_Track").play("rain_thunder_heavy")
	
	white.hide()
	anim.play("Fade from black 1s")
	yield(anim, "finished")
	player_cutscene = false


func change_stage(new_scene, entering_left, fade):
	player_cutscene = true
	current_scene = new_scene
	var prev_scene = get_tree().get_current_scene().get_name()
	
	#Fade out
	if fade:
		anim.play("Fade to black 1s")
		yield(anim, "finished")
	
	#Changing scene
	left_enter = entering_left
	var stage_path = "res://Scenes/" + new_scene + ".tscn"
	get_tree().change_scene(stage_path)
	
	#Set ambient sound/music
	if (new_scene == "Intro_cutscene" || new_scene == "Intro"):
		if (prev_scene != "Intro_cutscene"):
			get_node("Rain_Track").play("rain_thunder_heavy")
	else:
		get_node("Rain_Track").stop_all()
	
	if (new_scene == "Outside_Cabin"):
		if (prev_scene != "Inside_Cabin"):
			get_node("Montage_Track").play()
	else:
		get_node("Montage_Track").stop()
	
	#Fade back in
	if (prev_scene == "Intro_cutscene"):
		anim.play("Fade from black delayed")
		yield(anim, "finished")
	elif fade:
		anim.play("Fade from black 1s")
		yield(anim, "finished")
	
	player_cutscene = false


#parameter == 1 to set screen black, parameter == 0 to set screen white
func set_black(dark):
	if dark:
		black.show()
		white.hide()
		black.set_opacity(1)
	else:
		black.hide()
		white.show()
		white.set_opacity(1)


#Function to fade overlay in or out
#dark == true for black texture, false for white texture
#fade_in == true for fade to black/white, false for fade from black/white
func fade(dark, fade_in):
	if (dark && fade_in):
		anim.play("Fade from black 1s")
	elif (dark):
		anim.play("Fade to black 1s")
	elif (fade_in):
		anim.play("Fade from white 1s")
	else:
		anim.play("Fade to white 1s")