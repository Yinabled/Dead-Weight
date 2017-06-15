extends Node2D

var base_frame_time = 5

onready var timer = get_node("Timer")
onready var anim_sprite = get_node("AnimPlayer_Sprites")
onready var anim_fade1 = get_node("AnimPlayer_Fade1")
onready var anim_fade2 = get_node("AnimPlayer_Fade2")
onready var stage_anim = Stage_manager.get_node("AnimationPlayer")

onready var Cabin1 = get_node("Cabin_Room_Anim1")
onready var Cabin2 = get_node("Cabin_Room_Anim2")


func _ready():
	print(Stage_manager.player_bandaged)
	Stage_manager.player_bandaged = true
	print(Stage_manager.player_bandaged)
	
	Cabin1.set_opacity(0)
	Cabin2.set_opacity(0)
	get_node("MC_Sprite").set_frame(0)
	get_node("MC_Sprite").set_pos(Vector2(507, 577.8))
	
	timer.set_wait_time(1.5)
	timer.start()
	yield(timer, "timeout")
	anim_sprite.play("MC Falling")
	
	timer.set_wait_time(4)
	timer.start()
	yield(timer, "timeout")
	Stage_manager.fade_long(true, false)
	
	timer.set_wait_time(2)
	timer.start()
	yield(timer, "timeout")
	
	get_node("MC_Sprite").hide()
	Cabin1.set_opacity(1)
	anim_sprite.play("Montage0")
	Cabin2.set_opacity(0)
	Stage_manager.fade_long(true, true)
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim_sprite.play("Montage1")
	anim_fade1.play("Cabin1_Fade_Out")
	anim_fade2.play("Cabin2_Fade_In")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim_sprite.play("Montage2")
	anim_fade1.play("Cabin1_Fade_In")
	anim_fade2.play("Cabin2_Fade_Out")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim_sprite.play("Montage3")
	anim_fade1.play("Cabin1_Fade_Out")
	anim_fade2.play("Cabin2_Fade_In")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim_sprite.play("Montage4")
	anim_fade1.play("Cabin1_Fade_In")
	anim_fade2.play("Cabin2_Fade_Out")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	Stage_manager.change_stage("Puzzle_1", true, true)
