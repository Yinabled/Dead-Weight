extends Node2D

signal button_pressed
signal button_unpressed
var top
var collided = false
var sound_played = false
var button_unpressed = preload("res://Sprites/boxButton.tex")
var button_pressed = preload("res://Sprites/boxButtonPressed.tex")

func _ready():
	top = get_node("top")
	set_process(true)

func _process(delta):
	if top.is_colliding() && !collided:
		collided = true
		self.get_node("Sprite").set_texture(button_pressed)
		if top.get_collider().get_name().find("Box") > -1 && sound_played == false:
			get_node("SamplePlayer").play("box_falling_on_button")
			sound_played = true
		emit_signal("button_pressed")
	elif top.is_colliding() && collided:
		self.get_node("Sprite").set_texture(button_pressed)
	elif !top.is_colliding() && collided:
		collided = false
		sound_played = false
		self.get_node("Sprite").set_texture(button_unpressed)
		emit_signal("button_unpressed")
		
#	var distanceToBox = self.get_pos().distance_to(get_parent().get_node(box_name).get_pos())
#	if distanceToPlayer < 30:
#		if Input.is_action_pressed("ui_e"):
#			get_node("AnimationPlayer").play("button_pressed")
#			emit_signal("button_pressed")