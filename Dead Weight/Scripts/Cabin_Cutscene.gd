extends Node2D

var base_frame_time = 10

onready var timer = get_node("Timer")
onready var anim = get_node("AnimationPlayer")
onready var stage_anim = Stage_manager.get_node("AnimationPlayer")

onready var Cabin1 = get_node("Cabin_Room_Anim1")
onready var Cabin2 = get_node("Cabin_Room_Anim2")


func _ready():
	Cabin1.set_opacity(0)
	Cabin2.set_opacity(0)
	get_node("MC_Sprite").set_frame(0)
	get_node("MC_Sprite").set_pos(Vector2(507, 577.8))
	
	timer.set_wait_time(1.5)
	timer.start()
	yield(timer, "timeout")
	anim.play("MC Falling")
	
	timer.set_wait_time(4)
	timer.start()
	yield(timer, "timeout")
	Stage_manager.fade_long(true, false)
	
	timer.set_wait_time(2)
	timer.start()
	yield(timer, "timeout")
	
	get_node("MC_Sprite").hide()
	Cabin1.set_opacity(1)
	anim.play("Montage0")
	Cabin2.set_opacity(0)
	Stage_manager.fade_long(true, true)
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim.play("Montage1")
	anim.play("Cabin1_Fade_Out")
	anim.play("Cabin2_Fade_In")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim.play("Montage2")
	anim.play("Cabin1_Fade_Out")
	anim.play("Cabin2_Fade_In")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim.play("Montage3")
	anim.play("Cabin1_Fade_Out")
	anim.play("Cabin2_Fade_In")
	
	timer.set_wait_time(base_frame_time + 0)
	timer.start()
	yield(timer, "timeout")
	anim.play("Montage4")
	anim.play("Cabin1_Fade_In")
	anim.play("Cabin2_Fade_Out")
	
