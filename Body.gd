extends Node2D

enum FACE{HAPPY,SAD,NORMAL,ANGRY,SQUINT}

const LIGHT_PURE  = "_A"
const LIGHT_LIGHT = "_B"
const LIGHT_GRAY  = "_C"
const LIGHT_DARK  = "_D"

var face_state = FACE.NORMAL
var light_state = LIGHT_LIGHT

func change_light(to):
	if light_state == to:
		return
	light_state = to
	var ca = $APEyes.current_animation
	var ca_pos = $APEyes.current_animation_position
	# all animations have a _ delimiter
	var new_animation = ca.split("_")[0]
	
	$APEyes.play(new_animation+to)
	$APEyes.seek(ca_pos)
