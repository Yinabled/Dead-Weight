extends StaticBody2D

var top

func _ready():
	top = get_node("top")
	set_process(true)

func _process(delta):
	if top.is_colliding():
		self.get_node("AnimationPlayer").play("stepped")
		self.get_node("top").set_enabled(false)