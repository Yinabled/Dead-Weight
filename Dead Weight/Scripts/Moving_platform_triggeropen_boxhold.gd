extends RigidBody2D

var in_puzzle
var starting_position = Vector2()
var move_forward = true
var total_distance
var rate
var reach_position = Vector2()
var go = false

#Speed in pixels per second, adjusted in AnimationPlayer
export var block_distance = 5
export var open_time = 5
export var horizontal = true
export var short = true
export var connected_button = "box_button"
export var show_on_start = true
export var move_right = true

onready var button = get_parent().get_node(connected_button)

func _ready():
	
	starting_position = get_pos()
	reach_position = starting_position
	total_distance = block_distance * 50
	go = false
	
	if horizontal && move_right:
		reach_position.x = starting_position.x + total_distance
	elif horizontal && !move_right:
		reach_position.x = starting_position.x - total_distance
	elif !horizontal && move_right:
		reach_position.y = starting_position.y + total_distance
	else:
		reach_position.y = starting_position.y - total_distance
	
	rate = total_distance / open_time
	
	if !show_on_start:
		in_puzzle = false
		set_pos(get_pos() - Vector2(9000, 0))
	else:
		in_puzzle = true
	
	button.connect("button_pressed", self, "_on_button_pressed")
	button.connect("button_unpressed", self, "_on_button_unpressed")
	
	set_fixed_process(true)


func _fixed_process(delta):
	
	var pos_shift = Vector2()
#	var lm = 1
#	if !move_right:
#		lm = -1
	
	if move_forward && horizontal && go && move_right:
		pos_shift.x = rate * delta
		if (get_pos().x + pos_shift.x < reach_position.x):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(reach_position)
			go = false
	elif !move_forward && horizontal && go && move_right:
		pos_shift.x = -1 * rate * delta
		if (get_pos().x + pos_shift.x > starting_position.x):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(starting_position)
			go = false
			
	if move_forward && !horizontal && go && move_right:
		pos_shift.y = rate * delta
		if (get_pos().y + pos_shift.y < reach_position.y):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(reach_position)
			go = false
	elif !move_forward && !horizontal && go && move_right:
		pos_shift.y = -1 * rate * delta
		if (get_pos().y + pos_shift.y > starting_position.y):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(starting_position)
			go = false
			
	if !move_forward && horizontal && go && !move_right:
		pos_shift.x = rate * delta
		if (get_pos().x + pos_shift.x < starting_position.x):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(starting_position)
			go = false
	elif move_forward && horizontal && go && !move_right:
		pos_shift.x = -1 * rate * delta
		if (get_pos().x + pos_shift.x > reach_position.x):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(reach_position)
			go = false
			
	if !move_forward && !horizontal && go && !move_right:
		pos_shift.y = rate * delta
		if (get_pos().y + pos_shift.y < starting_position.y):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(starting_position)
			go = false
	elif move_forward && !horizontal && go && !move_right:
		pos_shift.y = -1 * rate * delta
		if (get_pos().y + pos_shift.y > reach_position.y):
			set_pos(get_pos() + pos_shift)
		else:
			set_pos(reach_position)
			go = false
	
#	if horizontal and go:
#		pos_shift.x = rate * delta 
#		if ((lm * (get_pos().x + lm * pos_shift.x)) < (lm * reach_position.x)) && ((lm * (get_pos().x + lm * pos_shift.x)) >= (lm * starting_position.x)):
#			print("omg what")
#			if (move_forward && move_right) || (!move_forward && !move_right):
#				set_pos(get_pos() + pos_shift)
#			else:
#				set_pos(get_pos() - pos_shift)
#		elif (lm * get_pos().x < lm * reach_position.x) && (lm * (get_pos().x + lm * pos_shift.x)) >= (lm * reach_position.x):
#			set_pos(reach_position)
#		elif (lm * get_pos().x >= starting_position.x) && ((lm * (get_pos().x + lm * pos_shift.x)) < (lm * starting_position.x)):
#			set_pos(starting_position)
#	elif !horizontal and go:
#		pos_shift.y = rate * delta
#		if ((get_pos().y + pos_shift.y) < reach_position.y) && ((get_pos().y + pos_shift.y) >= starting_position.y):
#			if (move_forward && move_right) || (!move_forward && !move_right):
#				set_pos(get_pos() + pos_shift)
#			else:
#				set_pos(get_pos() - pos_shift)

func _on_button_pressed():
	go = true
	move_forward = true

func _on_button_unpressed():
	go = true
	move_forward = false

func show(show_platform):
	if show_platform && !in_puzzle:
		set_pos(get_pos() + Vector2(9000, 0))
	elif !show_platform && in_puzzle:
		set_pos(get_pos() - Vector2(9000, 0))
