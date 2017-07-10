extends RigidBody2D

var in_puzzle = true

#Speed in pixels per second, adjusted in AnimationPlayer
export var speed = 0
export var speed_multiplier = 3
export var horizontal = true
export var short = true
export var right_first = true

export var move_on_start = true
export var show_on_start = true


func _ready():
	speed = 0
	
	if !show_on_start:
		set_in_puzzle(false)
	else:
		in_puzzle = true
	
	if move_on_start:
		move()
	
	set_fixed_process(true)


func _fixed_process(delta):
	
	var movement = Vector2()
	if horizontal:
		movement = Vector2(speed*speed_multiplier*delta, 0)
	else:
		movement = Vector2(0, speed*speed_multiplier*delta)
		
	set_pos(get_pos() + movement)


func move():
	if short && right_first:
		get_node("AnimationPlayer").play("Move right 6s")
	elif !short && right_first:
		get_node("AnimationPlayer").play("Move right 12s")
	elif short && !right_first:
		get_node("AnimationPlayer").play("Move left 6s")
	else:
		get_node("AnimationPlayer").play("Move left 12s")


func set_in_puzzle(show_platform):
	if show_platform && !in_puzzle:
		in_puzzle = true
		set_pos(get_pos() + Vector2(9000, 0))
	elif !show_platform && in_puzzle:
		in_puzzle = false
		set_pos(get_pos() - Vector2(9000, 0))
