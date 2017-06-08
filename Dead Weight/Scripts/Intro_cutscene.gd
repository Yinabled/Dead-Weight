extends Node

onready var timer = get_node("Timer")
onready var anim = get_node("AnimationPlayer")
onready var stage_anim = Stage_manager.get_node("AnimationPlayer")


func _ready():
	timer.set_wait_time(3)
	timer.start()
	yield(timer, "timeout")
	var dist_gun = anim.play("distant_gunshot_left")
	
	timer.set_wait_time(6)
	timer.start()
	yield(timer, "timeout")
	anim.play("closer_gunshot_left")
	
	timer.set_wait_time(4)
	timer.start()
	yield(timer, "timeout")
	anim.play("gun_dropped_on_dirt")
	
	timer.set_wait_time(1)
	timer.start()
	yield(timer, "timeout")
	anim.play("running_on_grass")
	yield(anim, "finished")
	
	Stage_manager.change_stage("Intro", true, false)
	Stage_manager.set_black(true)


func _on_Timer_timeout():
	pass