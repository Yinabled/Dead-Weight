extends KinematicBody2D
var left
var right
var bottom
var motion
var velocity
var MOVE_SPEED = 100
var original_speed = 50
var GRAVITY = 600
var FALL_ACCEL = 2
var fall_speed = 0
var left_pull
var right_pull

#func get_move_speed():
#	return MOVE_SPEED

func _ready():
	left = get_node("left")
	right = get_node("right")
	bottom = get_node("bottom")
	left_pull = get_node("left_pull")
	right_pull = get_node("right_pull")
	#original_speed = get_node("/root/World/Player").WALK_SPEED
	set_fixed_process(true)
	left.add_exception(self)
	right.add_exception(self)
	bottom.add_exception(self)
	left_pull.add_exception(self)
	right_pull.add_exception(self)

func _fixed_process(delta):
	var motion = Vector2(0,0)
	var velocity = Vector2(0,0)
	
	if left.is_colliding():
		motion.x = MOVE_SPEED
		print("left")
	
	if right.is_colliding():
		motion.x = -MOVE_SPEED
		print("right")
		
#	if left_pull.is_colliding() && Input.is_action_pressed("ui_ctrl") && Input.is_action_pressed("ui_left"):
#		motion.x = -MOVE_SPEED
#		print("left pull")
#		
#	if right_pull.is_colliding() && Input.is_action_pressed("ui_ctrl") && Input.is_action_pressed("ui_right"):
#		motion.x = MOVE_SPEED
#		print("right pull")
		
	if !bottom.is_colliding():
		motion.y += delta * GRAVITY * fall_speed
		fall_speed += FALL_ACCEL
#		print(fall_speed)
	else:
		fall_speed = 0
		
	
	if (left.is_colliding() || right.is_colliding()):
		#get_node("/root/World/Player").WALK_SPEED = MOVE_SPEED
		pass
	else:
		#get_node("/root/World/Player").WALK_SPEED = original_speed
		pass
	move(motion * delta)

