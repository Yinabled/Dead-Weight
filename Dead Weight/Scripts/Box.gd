extends KinematicBody2D
var left
var right
var motion
var MOVE_SPEED = 100
var original_speed = 50

func _ready():
	left = get_node("left")
	right = get_node("right")
	#original_speed = get_node("/root/World/Player").WALK_SPEED
	set_fixed_process(true)
	left.add_exception(self)
	right.add_exception(self)

func _fixed_process(delta):
	var motion = Vector2(0,0)
	if left.is_colliding():
		motion.x = MOVE_SPEED
	
	if right.is_colliding():
		motion.x = -MOVE_SPEED
	
	if (left.is_colliding() || right.is_colliding()):
		#get_node("/root/World/Player").WALK_SPEED = MOVE_SPEED
		pass
	else:
		#get_node("/root/World/Player").WALK_SPEED = original_speed
		pass
	move(motion*delta)
	

