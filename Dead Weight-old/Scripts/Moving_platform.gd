extends RigidBody2D

var in_puzzle = true

#Speed in pixels per second, adjusted in AnimationPlayer
export var speed = 0
export var speed_multiplier = 3
export var horizontal = true
export var short = true

export var move_on_start = true
export var show_on_start = true


func _ready():
	speed = 0
	
	if !show_on_start:
		set_in_puzzle(false)
	else:
		in_puzzle = true
	
	if move_on_start:
		if short:
			get_node("AnimationPlayer").play("Move 6s")
		else:
			get_node("AnimationPlayer").play("Move 12s")
	
	set_process(true)


func _process(delta):
	
	var movement = Vector2()
	if horizontal:
		movement = Vector2(speed*speed_multiplier*delta, 0)
	else:
		movement = Vector2(0, speed*speed_multiplier*delta)
		
	set_pos(get_pos() + movement)


func move():	
	if short:
		get_node("AnimationPlayer").play("Move 6s")
	else:
		get_node("AnimationPlayer").play("Move 12s")


func set_in_puzzle(show_platform):
	if show_platform && !in_puzzle:
		in_puzzle = true
		set_pos(get_pos() + Vector2(9000, 0))
	elif !show_platform && in_puzzle:
		in_puzzle = false
		set_pos(get_pos() - Vector2(9000, 0))
