extends RichTextLabel

func _process(_delta):
	var depth: int = round(GlobalFunctions.get_fairy_pos_center().y / 10)
	
	if depth > 0:
		text = str(depth) + "cm"
	else:
		text = ""
