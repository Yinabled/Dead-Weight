extends Node

var white
var black
var anim

var left_enter = true

var player_cutscene


func _ready():
	white = get_node("Overlay/Texture_White")
	black = get_node("Overlay/Texture_Black")
	anim = get_node("Animation")
	player_cutscene = true
	
	white.hide()
	anim.play("Fade from black 1s")
	yield(anim, "finished")
	player_cutscene = false

func change_stage(new_scene, entering_left):
	player_cutscene = true
	anim.play("Fade to black 1s")
	yield(anim, "finished")
	
	left_enter = entering_left
	var stage_path = "res://Scenes/" + new_scene + ".tscn"
	get_tree().change_scene(stage_path)
	
	anim.play("Fade from black 1s")
	yield(anim, "finished")
	player_cutscene = false