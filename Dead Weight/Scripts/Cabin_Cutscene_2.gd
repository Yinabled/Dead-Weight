extends Node2D

onready var timer = get_node("Timer")
onready var player = get_node("Player")
onready var stage_anim = Stage_manager.get_node("AnimationPlayer")

func _ready():
	player.get_node("AnimationPlayer").play("Idle_bandaged")
	Stage_manager.player_cutscene = true
	Stage_manager.player_bandaged = true
	Stage_manager.get_node("Return_Track").play()
	player.set_pos(Vector2(619, 622))
	
	timer.set_wait_time(2.3)
	timer.start()
	yield(timer, "timeout")
	player.get_node("Sprite").set_flip_h(true)
	
	timer.set_wait_time(1.5)
	timer.start()
	yield(timer, "timeout")
	player.get_node("AnimationPlayer").play("Running_bandaged")
	set_process(true)
	
	timer.set_wait_time(1)
	timer.start()
	yield(timer, "timeout")
	Stage_manager.change_stage("Outside_Cabin", false, true)


func _process(delta):
	player.move(Vector2(-250*delta, 0))