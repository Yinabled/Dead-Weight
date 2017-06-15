extends Node2D

signal box_button_pressed
export var box_name = "Box"
var top
var collided = false
var button_unpressed = preload("res://Sprites/boxButton.tex")
var button_pressed = preload("res://Sprites/boxButtonPressed.tex")

func _ready():
	top = get_node("top")
	set_process(true)

func _process(delta):
	if top.is_colliding() && collided == false:
		collided = true
		self.get_node("Sprite").set_texture(button_pressed)
		emit_signal("box_button_pressed")
	elif top.is_colliding() && collided == true:
		self.get_node("Sprite").set_texture(button_pressed)
	elif !top.is_colliding():
		collided = false
		self.get_node("Sprite").set_texture(button_unpressed)
#	var distanceToBox = self.get_pos().distance_to(get_parent().get_node(box_name).get_pos())
#	if distanceToPlayer < 30:
#		if Input.is_action_pressed("ui_e"):
#			get_node("AnimationPlayer").play("button_pressed")
#			emit_signal("button_pressed")