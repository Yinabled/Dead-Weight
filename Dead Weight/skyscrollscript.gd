extends TextureFrame

var timePassed = 0

func _ready():
	set_process(true)
	
func _process(delta):
	var curPos = get_pos()
	curPos.x = curPos.x - 0.1 * delta
	if curPos.x < get_size().x * 3 / 4 * -1:
		curPos.x = get_size().x * 1 / 4 * -1
	set_pos(curPos)