extends RigidBody2D

#Speed in pixels per second, adjusted in AnimationPlayer
export var speed = 100
export var speed_multiplier = 3
export var horizontal = true
export var short = true

export var auto_move = true

func _ready():
	if auto_move:
		if short:
			get_node("AnimationPlayer").play("Move 6s")
		else:
			get_node("AnimationPlayer").play("Move 12s")
	
	set_process(true)


func _process(delta):
	var movement = Vector2()
	if horizontal:
		movement = Vector2(speed*speed_multiplier*delta, 0)
	else:
		movement = Vector2(0, speed*speed_multiplier*delta)
		
	set_pos(get_pos() + movement)


func move():
	pass