extends Sprite

export var speed_multiplier = 0.6

export var Speed = 0.0


func _ready():
	hide()
	get_node("AnimationPlayer").play("Floating")
	set_process(true)


func _process(delta):
	set_pos(get_pos() + Vector2(Speed * speed_multiplier * delta, 0))