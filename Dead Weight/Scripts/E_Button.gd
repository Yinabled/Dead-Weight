extends Sprite

export var speed_multiplier = 0.6

export var Speed = 0.0
export var rotated = false


func _ready():
	hide()
	get_node("AnimationPlayer").play("Floating")
	set_process(true)


func _process(delta):
	if rotated:
		set_pos(get_pos() + Vector2(Speed * speed_multiplier * delta, 0))
	else:
		set_pos(get_pos() + Vector2(0, Speed * speed_multiplier * delta))