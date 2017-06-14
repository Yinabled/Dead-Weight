extends RayCast2D

onready var name = get_name()
var puzzle_num
var send_to_scene


func _ready():
	print(name)
	if name.find("Cabin") > -1:
		print("Cabin found")
		send_to_scene = "Cabin" #PROPER SCENE NAME?
	else:
		print("Cabin not found")
		puzzle_num = name
		puzzle_num.erase(0, 5)
		send_to_scene = "Puzzle_" + puzzle_num
	
	set_process(true)


func _process(delta):
	if is_colliding() && get_collider().get_name() == "Player":
		print(get_collider().get_name())