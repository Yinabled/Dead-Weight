extends Node2D

signal button_pressed
var pressed
var timer
var redButton = preload("res://Sprites/redButtonNew.tex")
var redButtonPressed = preload("res://Sprites/redButtonPressedNew.tex")
export var WAIT_TIME = 4

func _ready():
	timer = 0
	pressed = false
	get_node("Sprite").set_texture(redButton)
	set_process(true)

func _process(delta):
	var distanceToPlayer = self.get_pos().distance_to(get_parent().get_node("Player").get_pos())
	if distanceToPlayer < 80 && Input.is_action_pressed("ui_e") && pressed == false:
		get_node("Sprite").set_texture(redButtonPressed)
		emit_signal("button_pressed")
		pressed = true
		timer += delta
	elif pressed == true && timer <= WAIT_TIME:
		timer += delta
	elif pressed == true && timer > WAIT_TIME:
		get_node("Sprite").set_texture(redButton)
		timer = 0
		pressed = false