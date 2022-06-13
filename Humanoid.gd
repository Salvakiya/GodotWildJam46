extends Node2D


enum FACE{HAPPY,SAD,NORMAL,ANGRY,SQUINT}
enum LIGHT{PURE, LIGHT, GRAY, DARK}

var face_state = FACE.NORMAL
var light_state = LIGHT.LIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	change_light(light_state)
	pass # Replace with function body.

func change_light(to):
	light_state = to
	var material:ShaderMaterial = $Visual/Body.material
	material.set_shader_param("frame",to)
	material = $Visual/Eyes.material
	material.set_shader_param("frame",to)
