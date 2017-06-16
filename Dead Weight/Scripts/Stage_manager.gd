extends Node

onready var white = get_node("Overlay/Texture_White")
onready var black = get_node("Overlay/Texture_Black")
onready var anim = get_node("AnimationPlayer")
var player_cutscene = true
var player_bandaged = false

var left_enter = true
var current_scene

var puzzles_complete = 0


func _ready():
	change_stage(get_tree().get_current_scene().get_name(), true, false)
	
	anim.play("Fade from black 1s")
	yield(anim, "finished")
	player_cutscene = false


func change_stage(new_scene, entering_left, fade, white = false):
	player_cutscene = true
	var prev_scene = get_tree().get_current_scene().get_name()
	current_scene = new_scene
	
	#Fade out
	if fade:
		if white:
			anim.play("Fade to white 1s")
			yield(anim, "finished")
		else:
			anim.play("Fade to black 1s")
			yield(anim, "finished")
	
	
	#=============CHANGING SCENE=====================
	left_enter = entering_left
	var stage_path = "res://Scenes/" + new_scene + ".tscn"
	get_tree().change_scene(stage_path)
	
	
	if prev_scene.find("Puzzle") > -1 && !is_puzzle():
		var puzzle_num = prev_scene
		puzzle_num.erase(0, 7)
		puzzles_complete = puzzle_num
	
	
	#Setting ambient SOUND/MUSIC
	if (new_scene == "Main_Menu"):
		get_node("Main-Menu_Track").play()
	else:
		get_node("Main-Menu_Track").stop()
	
	if (new_scene == "Intro_cutscene" || new_scene == "Intro") && !get_node("Return_Track").is_playing():
		if (prev_scene != "Intro_cutscene"):
			get_node("Rain_Track").play("rain_thunder_heavy")
	else:
		get_node("Rain_Track").stop_all()
	
	if (new_scene == "Outside_Cabin" || new_scene == "Cabin_Cutscene") && !get_node("Return_Track").is_playing():
		if (prev_scene != "Cabin_Cutscene" && prev_scene != "Outside_Cabin"):
			get_node("Cabin_Track").play()
	else:
		get_node("Cabin_Track").stop()
	
	if (new_scene == "Brain_Space"):
		get_node("Brain_Space_Track").play()
	else:
		get_node("Brain_Space_Track").stop()
	
	
	#Resetting, or disabling, puzzle timer
	if is_puzzle():
		Puzzle_HUD.get_node("Timer_Sprite").restart_timer()
		if !get_node("Puzzle_1_Track").is_playing() && !get_node("Puzzle_2_Track").is_playing():
			var puzzle_num = new_scene
			puzzle_num.erase(0, 7)
			if int(puzzle_num) % 2 == 1:
				get_node("Puzzle_1_Track").play()
			else:
				get_node("Puzzle_2_Track").play()
		
	else:
		Puzzle_HUD.get_node("Timer_Sprite").stop_timer()
		get_node("Puzzle_1_Track").stop()
		get_node("Puzzle_2_Track").stop()
	
	
	#Fade back in
	if (prev_scene == "Intro_cutscene"):
		anim.play("Fade from black delayed")
		yield(anim, "finished")
	elif fade:
		if white:
			anim.play("Fade from white 1s")
			yield(anim, "finished")
		else:
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
#fade_scene_in == true for fade to black/white, false for fade from black/white
func fade(dark, fade_scene_in):
	if (dark && fade_scene_in):
		anim.play("Fade from black 1s")
	elif (dark):
		anim.play("Fade to black 1s")
	elif (fade_scene_in):
		anim.play("Fade from white 1s")
	else:
		anim.play("Fade to white 1s")

func fade_long(dark, fade_scene_in):
	if (dark && fade_scene_in):
		anim.play("Fade from black delayed")
	elif (dark):
		anim.play("Fade to black 2s")
	elif (fade_scene_in):
#		anim.play("Fade from white 1s")
		pass
	else:
#		anim.play("Fade to white 1s")
		pass


func is_puzzle():
	if current_scene.find("Puzzle") > -1:
		return true
	else:
		return false