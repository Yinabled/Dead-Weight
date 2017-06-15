extends StaticBody2D

var top
var timer

func _ready():
	top = get_node("top")
	timer = 0
	set_process(true)

func _process(delta):
	print(timer)
	if top.is_colliding():
		if timer == 0:
			print("helpme")
			self.get_node("AnimationPlayer").play("stepped")
			timer += delta
		elif timer <= 6:
			timer += delta
		elif timer > 6:
			timer = 0
#	yield(get_node("AnimationPlayer"), "finished")