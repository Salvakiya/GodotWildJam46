extends KinematicBody2D


enum FACE{HAPPY,SAD,NORMAL,ANGRY,SQUINT}
enum LIGHT{DEFAULT,PURE, LIGHT, GRAY, DARK}

export(FACE) var face_state = FACE.NORMAL
var next_face_state = FACE.NORMAL
export(LIGHT) var light_state = LIGHT.PURE

const MOVE_SPEED = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	change_light(light_state)
	change_expression(face_state)
	$Visual/BodyA.visible = !$Visual/BodyB.visible
	$Visual/BodyB.visible = !$Visual/BodyA.visible
	$Visual/Eyes.connect("animation_finished", self, "change_expression", [FACE.NORMAL])


func change_expression(to):
	if face_state == to:
		return
	face_state = to
	match to:
		FACE.HAPPY:
			$Visual/Eyes.animation = "Happy"
		FACE.SAD:
			$Visual/Eyes.animation = "Sad"
		FACE.NORMAL:
			$Visual/Eyes.animation = "Normal"
		FACE.ANGRY:
			$Visual/Eyes.animation = "Angry"
		FACE.SQUINT:
			$Visual/Eyes.animation = "Squint"

func change_light(to):
	light_state = to
	var material:ShaderMaterial = $Visual/BodyA.material
	material.set_shader_param("frame",to)
	material = $Visual/BodyB.material
	material.set_shader_param("frame",to)
	material = $Visual/Eyes.material
	material.set_shader_param("frame",to)

func _physics_process(delta):
	var input = Vector2(
		(1 if Input.is_action_pressed("move_right") else 0)-(1 if Input.is_action_pressed("move_left") else 0),
		(1 if Input.is_action_pressed("move_down") else 0)-(1 if Input.is_action_pressed("move_up") else 0)
	)
	if Input.is_action_just_pressed("attack"):
		change_expression(FACE.ANGRY)
		light_state+=1
		if light_state==5:
			light_state=1
		change_light(light_state)
	if input.x!=0 or input.y!=0:
		$Visual/BodyA.animation = "Run"
		$Visual/BodyB.animation = "Run"
		if input.x!=0:
			$Visual/BodyA.scale.x = input.x
			$Visual/BodyB.scale.x = input.x
			$Visual/Eyes.scale.x = input.x
	else:
		$Visual/BodyA.animation = "Idle"
		$Visual/BodyB.animation = "Idle"

	input = input.normalized()*MOVE_SPEED
	move_and_slide(input)
