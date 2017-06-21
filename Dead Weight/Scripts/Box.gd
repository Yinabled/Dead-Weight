extends KinematicBody2D
var left
var right
var bottom
var MOVE_SPEED = 100
var original_speed = 50
var GRAVITY = 600
var FALL_ACCEL = 2
var fall_speed = 0

#func get_move_speed():
#	return MOVE_SPEED

func _ready():
	left = get_node("left")
	right = get_node("right")
	bottom = get_node("bottom")
	#original_speed = get_node("/root/World/Player").WALK_SPEED
	set_fixed_process(true)
	left.add_exception(self)
	right.add_exception(self)
	bottom.add_exception(self)

func _fixed_process(delta):
	var velocity = Vector2(0,0)
	
	if left.is_colliding():
		velocity.x += MOVE_SPEED
#		print("left")
	
	if right.is_colliding():
		velocity.x += -MOVE_SPEED
#		print("right")
		
#	if left_pull.is_colliding() && Input.is_action_pressed("ui_ctrl") && Input.is_action_pressed("ui_left"):
#		motion.x = -MOVE_SPEED
#		print("left pull")
#		
#	if right_pull.is_colliding() && Input.is_action_pressed("ui_ctrl") && Input.is_action_pressed("ui_right"):
#		motion.x = MOVE_SPEED
#		print("right pull")
		
	if !bottom.is_colliding():
		velocity.y += delta * GRAVITY * fall_speed
		fall_speed += FALL_ACCEL
#		print(fall_speed)
	else:
		fall_speed = 0
		
	if bottom.is_colliding() && bottom.get_collider().get_name().find("Moving_plat") != -1:
		velocity.x += bottom.get_collider().get_linear_velocity().x
		velocity.y += bottom.get_collider().get_linear_velocity().y
	
	if (left.is_colliding() || right.is_colliding()):
		#get_node("/root/World/Player").WALK_SPEED = MOVE_SPEED
		pass
	else:
		#get_node("/root/World/Player").WALK_SPEED = original_speed
		pass
	var motion = velocity * delta
	motion = move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

