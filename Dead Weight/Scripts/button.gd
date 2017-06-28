extends Node2D


var button_radius = 65

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
	if distanceToPlayer < button_radius && Input.is_action_pressed("ui_e") && pressed == false:
		get_node("Sprite").set_texture(redButtonPressed)
		get_node("SamplePlayer").play("button_click")
		emit_signal("button_pressed")
		pressed = true
		timer += delta
	elif pressed == true && timer <= WAIT_TIME:
		timer += delta
	elif pressed == true && timer > WAIT_TIME:
		get_node("Sprite").set_texture(redButton)
		get_node("SamplePlayer").play("button_unclick")
		timer = 0
		pressed = false
	
	#Showing E_Button
	if distanceToPlayer < button_radius:
		get_node("E_Button").show()
	else:
		get_node("E_Button").hide()


func set_WAIT_TIME(new_wait_time):
	WAIT_TIME = new_wait_time

func get_WAIT_TIME():
	return WAIT_TIME