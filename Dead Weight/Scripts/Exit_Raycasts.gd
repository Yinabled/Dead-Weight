extends RayCast2D


func _ready():
	set_enabled(true)
	set_process(true)

func _process(delta):
	if is_colliding() && get_collider().get_name() == "Player":
		set_enabled(false)
		Stage_manager.change_stage("Brain_Space", true, true)