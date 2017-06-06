extends KinematicBody2D

const GRAVITY = 600.0
const FALL_ACCEL = 4
var WALK_SPEED = 400
const JUMP_HEIGHT = 1000
var feet

var velocity = Vector2()

var direction = ""
var current_animation = ""
var new_animation = "Idle"
var current_sfx = ""
var new_sfx = ""

var left_limit = -10000000
var right_limit = 10000000
var left_scene
var right_scene


#Scene intialization resources
#   "scene_name": [left, top, right, bottom, ground_height, left_scene, right_scene, left_enter]
var scene_resources = {
	"Intro": [0, 0, 2800, 1000, 932, null, "Outside_Cabin", true],
	"Outside_Cabin": [-1440, -530, 1440, 541, 424, "Intro", null, true],
	"rorschachtest": [0, 0, 2500, 2500, 2100, null, null, true],
	"TESTMEME": [0, 0, 300, 300, 140, null, null, true]
}


func _ready():
	init_scene(scene_resources[get_parent().get_name()])
	feet = get_node("Feet")
	feet.add_exception(self)
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
		
		#Actual movement
		var motion = velocity * delta
		motion = move(motion)
		
		var floor_velocity = Vector2()
		
		if (is_colliding()):
			var n = get_collision_normal()
			motion = n.slide(motion)
			velocity = n.slide(velocity)
			move(motion)
			print("test " + str(get_collider_metadata()))
		
		floor_velocity = get_collider_velocity()
		
		if (floor_velocity != Vector2()):
			move(floor_velocity * delta)
			
		#print(floor_velocity)
		
		#Playing animation if it is new
		if (new_animation != current_animation):
			get_node("AnimationPlayer").play(new_animation)
			current_animation = new_animation
		
		#Checking if the player is exiting the scene
		if (get_pos().x > right_limit + 24 && right_scene != null):
			Stage_manager.change_stage(right_scene, true)
		elif (get_pos().x < left_limit - 27 && left_scene != null):
			Stage_manager.change_stage(left_scene, false)
	


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
