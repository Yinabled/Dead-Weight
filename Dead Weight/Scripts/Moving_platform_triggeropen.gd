extends RigidBody2D

var in_puzzle
var playing_animation = false

#Speed in pixels per second, adjusted in AnimationPlayer
export var speed = 0
export var speed_multiplier = 3
export var horizontal = true
export var short = true
export var connected_button = "button"

export var move_on_start = false
export var show_on_start = true
export var move_right = true

onready var button = get_parent().get_node(connected_button)

onready var animation = get_node("AnimationPlayer")

func _ready():
	speed = 0
	
	if !show_on_start:
		in_puzzle = false
		set_pos(get_pos() - Vector2(9000, 0))
	else:
		in_puzzle = true
	
	if move_on_start:
		move()
	
	button.connect("button_pressed", self, "_on_button_pressed")
	button.connect("button_unpressed", self, "_on_button_unpressed")
	
	animation.connect("finished", self, "_on_animation_finished")
	
	set_process(true)


func _process(delta):

	var movement = Vector2()

	if horizontal:
		movement = Vector2(speed*speed_multiplier*delta, 0)
	else:
		movement = Vector2(0, speed*speed_multiplier*delta)
		
	set_pos(get_pos() + movement)

func _on_button_pressed():
	if !playing_animation:
		move()

func _on_animation_finished():
	playing_animation = false

func move():
#	print(str(move_right))
	playing_animation = true
	if move_right:
		if short:
			get_node("AnimationPlayer").play("Move right short")
		else:
			get_node("AnimationPlayer").play("Move right long")
		move_right = false
	else:
		if short:
			get_node("AnimationPlayer").play("Move left short")
		else:
			get_node("AnimationPlayer").play("Move left long")
		move_right = true

func show(show_platform):
	if show_platform && !in_puzzle:
		set_pos(get_pos() + Vector2(9000, 0))
	elif !show_platform && in_puzzle:
		set_pos(get_pos() - Vector2(9000, 0))
