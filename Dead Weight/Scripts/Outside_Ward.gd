extends Node2D

var gun_rise_speed = 32

var triggered = false

onready var Player = get_node("Player")
onready var timer = get_node("Timer")
onready var stage_anim = Stage_manager.get_node("AnimationPlayer")


func _ready():
	Player.set_scale(Vector2(1, 1))
	set_process(true)

func _process(delta):
#Animation trigger for Outside_Ward
	if Player.get_pos().x < 820 && !triggered:
#		get_node("AnimationPlayer").play("Player_Falling")
#		Player.get_node("AnimationPlayer").play("Falling")
		Player.get_node("AnimationPlayer").play("Idle_bandaged")
		triggered = true
		Stage_manager.player_cutscene = true
		Player.get_node("Sprite").set_flip_h(true)
		timer.set_wait_time(4)
		timer.start()
	
	if triggered:
		get_node("Gun").move_local_y(-delta * gun_rise_speed)


func _on_Timer_timeout():
	Stage_manager.change_stage("Final_Memory", true, true, true)
