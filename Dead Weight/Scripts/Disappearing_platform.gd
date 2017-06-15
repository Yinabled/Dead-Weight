extends StaticBody2D

var top
var timer
const ANIM_TIME = 3.5
var collided

func _ready():
	top = get_node("top")
	timer = 0
	collided = false
	set_process(true)

func _process(delta):
	#print(timer)
	if top.is_colliding() && collided == false && timer == 0:
		self.get_node("AnimationPlayer").play("stepped")
		collided = true
		timer += delta
	elif collided == true && timer <= ANIM_TIME:
		timer += delta
	elif collided == true && timer > ANIM_TIME:
		timer = 0
		collided = false
#	yield(get_node("AnimationPlayer"), "finished")