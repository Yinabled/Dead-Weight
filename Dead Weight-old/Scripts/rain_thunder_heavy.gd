extends SamplePlayer2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	play("rain_thunder_heavy")
	set_process(true)

func _process(delta):
#	if get_parent().get_node("Player").get_pos().x > 1350:
#		set_volume(0,-30)
#		print(get_default_volume_db())
#		print(get_parent().get_node("Player").get_pos().x)
#	if get_parent().get_node("Player").get_pos().x <= 1350:
#		set_volume(0,20)
#		print(get_default_volume_db())
#		print(get_parent().get_node("Player").get_pos().x)
	pass