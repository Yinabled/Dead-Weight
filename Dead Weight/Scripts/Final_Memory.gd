extends Node2D

var camera_speed = 120
var camera_vert_speed = 75
var player_movespeed = 300
var max_credits_height = -480

var triggered = false
var player_moving = false
var camera_moving_up = false

onready var timer = get_node("Timer")
onready var camera = get_node("Camera2D")
onready var Player = get_node("Player")
onready var scene_anim = get_node("AnimationPlayer")
onready var sprite_anim = get_node("Sprite_Anim")
onready var stage_anim = Stage_manager.get_node("AnimationPlayer")
onready var samples = get_node("SamplePlayer")


func _ready():
	scene_anim.play("Aiming")
	Player.set_opacity(1)
	
	set_process(true)

func _process(delta):
#Animation trigger for final memory scene
	if Player.get_pos().x > 4050 && !triggered:
		triggered = true
		Stage_manager.player_cutscene = true
		anim_continue()
	
	if triggered && camera.get_pos().x < 4900:
		camera.move_local_x(delta * camera_speed)
	
	if player_moving:
		Player.move(Vector2(delta * player_movespeed, 0))
	
	if camera_moving_up && camera.get_pos().y > max_credits_height:
		camera.set_limit(1, camera.get_limit(1) - delta * camera_vert_speed)
		camera.move_local_y(-delta * camera_vert_speed)

func anim_continue():
	sprite_anim.play("Player_fadeout")
	get_node("Player/Camera2D").clear_current()
	Player.get_node("AnimationPlayer").play("Idle_bandaged")
	camera.set_pos(Player.get_node("Camera2D").get_camera_pos())
	camera.make_current()
	
	timer.set_wait_time(9)
	timer.start()
	yield(timer, "timeout")
	Stage_manager.set_black(false)
	scene_anim.play("Shot")
	samples.play("9_mm_gunshot_v3")
	samples.play("ears_ringing")
	Stage_manager.get_node("Return_Track").stop()
	
	timer.set_wait_time(3)
	timer.start()
	yield(timer, "timeout")
	stage_anim.play("Fade from white 1s")
	
	timer.set_wait_time(6)
	timer.start()
	yield(timer, "timeout")
	scene_anim.play("No MC")
	Player.set_pos(Vector2(4912, 981))
	Player.set_opacity(1)
	Player.get_node("AnimationPlayer").play("Running with Gun")
	player_moving = true
	
	timer.set_wait_time(6)
	timer.start()
	yield(timer, "timeout")
	get_node("SamplePlayer").set_default_pan(0.7)
	get_node("SamplePlayer").play("9_mm_gunshot_v3")
	
	timer.set_wait_time(3)
	timer.start()
	yield(timer, "timeout")
	Stage_manager.get_node("Ending_Track").play()
	
	timer.set_wait_time(6)
	timer.start()
	yield(timer, "timeout")
	camera_moving_up = true


func _on_Timer_timeout():
	pass # replace with function body
