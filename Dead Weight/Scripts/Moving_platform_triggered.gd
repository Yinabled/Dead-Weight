extends RigidBody2D

var in_puzzle
var lm

#Speed in pixels per second, adjusted in AnimationPlayer
export var speed = 0
export var speed_multiplier = 3
export var horizontal = true
export var connected_button = "button"
export var short_long_vlong = "short"
export var move_right = true

export var move_on_start = false
export var show_on_start = true

onready var button = get_parent().get_node(connected_button)

func _ready():
	speed = 0
	
	if move_right:
		lm = 1
	else:
		lm = -1
	
	if !show_on_start:
		in_puzzle = false
		set_pos(get_pos() - Vector2(9000, 0))
	else:
		in_puzzle = true
	
	if move_on_start:
		move()
	
	button.connect("button_pressed", self, "_on_button_pressed")
	
	set_process(true)


func _process(delta):

	var movement = Vector2()

	if horizontal:
		movement = Vector2(lm*speed*speed_multiplier*delta, 0)
	else:
		movement = Vector2(0, lm*speed*speed_multiplier*delta)
		
	set_pos(get_pos() + movement)

func _on_button_pressed():
	move()

func move():
	if short_long_vlong == "short":
		get_node("AnimationPlayer").play("Move 6s")
	elif short_long_vlong == "long":
		get_node("AnimationPlayer").play("Move 13s")
	elif short_long_vlong == "vlong":
		get_node("AnimationPlayer").play("Move 20s")
	elif short_long_vlong == "vvlong":
		get_node("AnimationPlayer").play("Move 26s")
	else:
		get_node("AnimationPlayer").play("Move 6s")


func show(show_platform):
	if show_platform && !in_puzzle:
		set_pos(get_pos() + Vector2(9000, 0))
	elif !show_platform && in_puzzle:
		set_pos(get_pos() - Vector2(9000, 0))
