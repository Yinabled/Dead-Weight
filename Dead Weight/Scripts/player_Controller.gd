extends KinematicBody2D

#ORIGINAL SCALE: 0.3918

const GRAVITY = 600.0
const FALL_ACCEL = 4
var WALK_SPEED = 300
const JUMP_HEIGHT = 1000
var feet

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
	"Outside_Cabin": [0, 0, 2880, 1080, 900, "Intro", null, true, 2223, 816],
	"TESTSCENE": [0, 0, 400, 400, 50, null, null, true],
	"Brain_Space": [10, 0, 5800, 1200, 992, null, null, true, 390],
	"Puzzle_1": [-25, -25, 2100, 2600, 2513, null, null, true],
	"Puzzle_2": [-25, -25, 2100, 2600, 2513, null, null, true],
	"Puzzle_3": [-25, -25, 2100, 2600, 2513, null, null, true],
	"Puzzle_4": [-25, -25, 2100, 2600, 2513, null, null, true],
	"Puzzle_5": [-25, -25, 2100, 2600, 2363, null, null, true, 127],
	"Puzzle_6": [-25, -25, 2100, 2600, 2513, null, null, true],
	"Outside_Ward": [0, 0, 1920, 1080, 898, null, null, false],
	"Final_Memory": [10, 0, 5800, 1200, 951, null, null, true, 390]
}


func _ready():
	bandaged = Stage_manager.player_bandaged
	
	if get_parent().get_name().find("Cutscene") == -1:
		init_scene(scene_resources[get_parent().get_name()])
	feet = get_node("Feet")
	feet.add_exception(self)
	
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
		var motion = velocity * delta
		motion = move(motion)
		
		if (is_colliding()):
			var n = get_collision_normal()
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			move(motion)
		
		
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
	
	
	#Starting the player position at whichever side they are entering from
	left_enter = Stage_manager.left_enter
	if (left_enter):
		set_pos(Vector2(left + 40, ground_height))
		get_node("Sprite").set_flip_h(false)
	else:
		set_pos(Vector2(right - 40, ground_height))
		get_node("Sprite").set_flip_h(true)
	
	if (arr.size() == 9):
		set_pos(Vector2(arr[8], ground_height))
	elif (arr.size() == 10 && Stage_manager.player_bandaged):
		set_pos(Vector2(arr[8], arr[9]))
	
	if (get_tree().get_current_scene().get_name() == "Intro" && bandaged):
		left_scene = "Outside_Ward"
		get_tree().get_current_scene().get_node("Left_barrier").set_pos(Vector2(-100000, 0))
	
	
	if (left_scene != null):
		left_limit = left
	else:
		left_limit = -10000000
	if (right_scene != null):
		right_limit = right
	else:
		right_limit = 10000000


func set_idle():
	if bandaged:
		get_node("AnimationPlayer").play("Idle_bandaged")
	else:
		get_node("AnimationPlayer").play("Idle")