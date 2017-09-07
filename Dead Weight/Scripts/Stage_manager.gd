extends Node

onready var white = get_node("Overlay/Texture_White")
onready var black = get_node("Overlay/Texture_Black")
onready var anim = get_node("AnimationPlayer")
onready var music_tracks = get_tree().get_nodes_in_group("OST")
var OST_max_volumes ={}
var user_volume = 1
var current_track

var player_cutscene = true
var player_bandaged = false
var puzzles_complete = 0

var left_enter = true
var current_scene
var changing_stage = false


func _ready():
	#Initializing OST dictionary
	for track in music_tracks:
		OST_max_volumes[track.get_name()] = track.get_volume()
	
	change_stage(get_tree().get_current_scene().get_name(), true, false)
	
	anim.play("Fade from black 1s")
	yield(anim, "finished")
	player_cutscene = false


func change_stage(new_scene, entering_left, fade, white = false):
	if changing_stage && !get_tree().get_current_scene().get_name() == "Memories":
		return
	
	if get_tree().get_current_scene().has_node("Player"):
		get_tree().get_current_scene().get_node("Player").set_idle()
	
	changing_stage = true
	player_cutscene = true
	var prev_scene = get_tree().get_current_scene().get_name()
	current_scene = new_scene
	
	if new_scene == "Intro_cutscene":
		get_node("Overlay/Dead_Weight_Text").show()
	else:
		get_node("Overlay/Dead_Weight_Text").hide()
	
	#Fade out (audio and visual)
	if fade:
		if !(is_puzzle() || new_scene == "Cabin_Cutscene" || new_scene == "Outside_Cabin" || new_scene == "Intro" || new_scene == "Outside_Ward" || new_scene == "Final_Memory"):
			fade_tracks()
		
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
	
	
	#===============SOUND/MUSIC========================
	if (new_scene == "Main_Menu"):
		get_node("Main-Menu_Track").play()
	else:
		get_node("Main-Menu_Track").stop()
	
	if (new_scene == "Intro") && !get_node("Return_Track").is_playing():
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
	
	get_node("Ending_Track").stop()
	
	
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
		#Track fade-in
#		if !(new_scene == "Outside_Cabin" || new_scene == "Cabin_Cutscene" || new_scene == "Outside_Ward" || new_scene == "Final_Memory" || new_scene == "Intro"):
#			fade_tracks(false)
		
		if white:
			anim.play("Fade from white 1s")
			yield(anim, "finished")
		else:
			anim.play("Fade from black 1s")
			yield(anim, "finished")
	
	fade_tracks(true, true)
	
	Stage_manager.get_node("Overlay/Dead_Weight_Text").hide()
	player_cutscene = false
	changing_stage = false


func fade_tracks(fade_out = true, reset_volume = false):
	for track in Stage_manager.music_tracks:
		if track.is_playing():
			current_track = track
	
	if current_track == null:
		return
	
	var max_volume = OST_max_volumes[current_track.get_name()]
	
	if reset_volume:
		current_track.set_volume(max_volume * user_volume)
		return
	
	var multiplier = 0
	var increment = 0.05
	if fade_out:
		multiplier = user_volume
		increment = -0.05
	
	for i in range(20):
		multiplier += increment
		current_track.set_volume(max_volume * multiplier)
		get_node("Timer").start()
		yield(get_node("Timer"), "timeout")


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

func _on_Timer_timeout():
	pass
