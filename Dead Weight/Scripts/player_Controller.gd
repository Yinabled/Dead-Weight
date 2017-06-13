extends KinematicBody2D

const GRAVITY = 600.0
const FALL_ACCEL = 4
var WALK_SPEED = 400
const JUMP_HEIGHT = 1000
var feet
var left_collider
var right_collider
var motion

var velocity = Vector2()

var direction = ""
var current_animation = ""
var new_animation = "Idle"
var bandaged

var left_limit = -10000000
var right_limit = 10000000
var left_scene
var right_scene


#Scene intialization resources
#   "scene_name": [left, top, right, bottom, ground_height, left_scene, right_scene, left_enter]
var scene_resources = {
	"Intro": [0, 0, 2800, 1000, 934, null, "Outside_Cabin", true],
	"Outside_Cabin": [-1440, -540, 1440, 540, 402, "Intro", null, true],
	"Puzzle_1": [-25, -25, 2100, 2600, 1010, null, null, true],
	"TESTSCENE": [0, 0, 700, 350, 70, null, null, true]
}


func _ready():
	init_scene(scene_resources[get_parent().get_name()])
	feet = get_node("Feet")
	feet.add_exception(self)
	left_collider = get_node("Left")
	left_collider.add_exception(self)
	right_collider = get_node("Right")
	right_collider.add_exception(self)
	
	bandaged = Stage_manager.player_bandaged
	if bandaged:
		get_node("AnimationPlayer").play("Idle_bandaged")
	else:
		get_node("AnimationPlayer").play("Idle")
	
	set_fixed_process(true)


func _fixed_process(delta):
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var cutscene = Stage_manager.player_cutscene
	
	if (!cutscene):
		#Moving left, right, or idle
		if left && right:
			if (direction == "just_left"):
				velocity.x =  WALK_SPEED
				new_animation = "Running"
				get_node("Sprite").set_flip_h(false)
			elif (direction == "just_right"):
				velocity.x = -WALK_SPEED
				new_animation = "Running"
				get_node("Sprite").set_flip_h(true)
		elif left:
			velocity.x = -WALK_SPEED
			new_animation = "Running"
			direction = "just_left"
			get_node("Sprite").set_flip_h(true)
		elif right:
			velocity.x =  WALK_SPEED
			new_animation = "Running"
			direction = "just_right"
			get_node("Sprite").set_flip_h(false)
		else:
			velocity.x = 0
			new_animation = "Idle"
			direction = ""
		
		#Jumping or falling
		if feet.is_colliding():
			if(Input.is_action_pressed("ui_up")):
				velocity.y = -JUMP_HEIGHT
				get_node("SamplePlayer2D").play("jumping_on_grass")
		else:
			velocity.y += delta * GRAVITY * FALL_ACCEL
			new_animation = "Jumping"
		
		if feet.is_colliding() && feet.get_collider().get_name().find("Moving_plat") != -1:
			velocity.x += feet.get_collider().get_linear_velocity().x
			if !Input.is_action_pressed("ui_up"):
				velocity.y = feet.get_collider().get_linear_velocity().y
		

		
		#Actual movement
		motion = velocity * delta
		motion = move(motion)
		
		if (is_colliding()):
			var n = get_collision_normal()
			motion = n.slide(motion)
			velocity = n.slide(velocity)
#			if left_collider.is_colliding():
#				print(left_collider.get_collider().get_name())
#			
#			if left_collider.is_colliding() && left_collider.get_collider().get_name().find("Box") != -1 && Input.is_action_pressed("ui_ctrl") && right:
#				motion.x = 100 #Box MOVE_SPEED variable
#				print("LEFT GO FAM")
#				left_collider.get_collider().move(motion*delta)
#			if right_collider.is_colliding() && right_collider.get_collider().get_name().find("Box") != -1 && Input.is_action_pressed("ui_ctrl") && left:
#				motion.x = -100 #Box MOVE_SPEED variable
#				right_collider.get_collider().move(motion*delta)
#				print("RIGHT GO FAM")
#			move(motion * delta)
			move(motion)
#			var collider = feet.get_collider()
#			print(collider.get_type())
#			if(collider extends RigidBody2D):
#				velocity.x /= 2
#				get_parent().get_node("Box_rigid").set_linear_velocity(velocity)
		
		#Converting animations to bandaged
		if (new_animation == "Idle" && bandaged):
			new_animation = "Idle_bandaged"
		elif (new_animation == "Jumping" && bandaged):
			new_animation = "Jumping_bandaged"
		elif (new_animation == "Running" && bandaged):
			new_animation = "Running_bandaged"
		
		#Playing animation if it is new
		if (new_animation != current_animation):
			get_node("AnimationPlayer").play(new_animation)
			current_animation = new_animation
		
		#Checking if the player is exiting the scene
		if (get_pos().x > right_limit + 24 && right_scene != null):
			Stage_manager.change_stage(right_scene, true, true)
		elif (get_pos().x < left_limit - 27 && left_scene != null):
			Stage_manager.change_stage(left_scene, false, true)
	
func get_motion():
	return velocity

#Initializing the camera and scene limits
func init_scene(var arr):
	var left = arr[0]
	var top = arr[1]
	var right = arr[2]
	var bottom = arr[3]
	var ground_height = arr[4]
	left_scene = arr[5]
	right_scene = arr[6]
	var left_enter = arr[7]
	
	var camera = get_node("Camera2D")
	camera.set_limit(0, left)
	camera.set_limit(1, top)
	camera.set_limit(2, right)
	camera.set_limit(3, bottom)
	
	if (left_scene != null):
		left_limit = left
	else:
		left_limit = -10000000
	if (right_scene != null):
		right_limit = right
	else:
		right_limit = 10000000
	
	
	#Starting the player position at whichever side they are entering from
	left_enter = Stage_manager.left_enter
	if (left_enter):
		set_pos(Vector2(left + 40, ground_height))
		get_node("Sprite").set_flip_h(false)
	else:
		set_pos(Vector2(right - 40, ground_height))
		get_node("Sprite").set_flip_h(true)
