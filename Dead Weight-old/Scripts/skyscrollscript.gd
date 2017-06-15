extends TextureFrame

var scroll_time = 0.1

var timer = 0
var temp_time = 0

func _ready():
	set_process(true)
	
func _process(delta):
	timer += delta
	var curPos = get_pos()
	
	if (temp_time + scroll_time < timer):
		curPos.x = curPos.x - 1
		if curPos.x < get_size().x * 3 / 4 * -1:
			curPos.x = get_size().x * 1 / 4 * -1
		set_pos(curPos)
		temp_time += scroll_time
	
