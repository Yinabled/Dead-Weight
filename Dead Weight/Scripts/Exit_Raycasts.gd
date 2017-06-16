extends RayCast2D


func _ready():
	set_enabled(true)
	set_process(true)

func _process(delta):
	if is_colliding() && get_collider().get_name() == "Player":
		set_enabled(false)
		Stage_manager.get_node("Puzzle_1_Track").stop()
		Stage_manager.get_node("Puzzle_2_Track").stop()
		Stage_manager.get_node("Extra_SFX").play("exhale")
		if get_name() == "Exit_6":
			Stage_manager.change_stage("Cabin_Cutscene_2", true, true, true)
		else:
			Stage_manager.change_stage("Memories", true, true, true)