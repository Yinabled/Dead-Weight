extends Node2D

signal button_pressed

func _ready():
	set_process(true)

func _process(delta):
	var distanceToPlayer = self.get_pos().distance_to(get_parent().get_node("Player").get_pos())
	if distanceToPlayer < 30:
		if Input.is_action_pressed("ui_e"):
			get_node("AnimationPlayer").play("button_pressed")
			emit_signal("button_pressed")